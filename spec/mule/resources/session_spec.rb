# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mule::Resources::Session, type: :model do
  describe '#find!', :vcr do
    subject { described_class.find!(session_token) }

    before { configuration_by_environments! }

    context 'with unknown session' do
      let(:session_token) { '123456' }

      it { expect { subject }.to raise_error(Mule::Resources::NotFoundError, "The session can't be found") }
      it { expect(rescue_unknown_session_error.response.code).to eq(400) }
      it { expect(rescue_unknown_session_error.response.body).to match_response_schema('resources/session/find_400') }

      def rescue_unknown_session_error
        subject
      rescue Mule::Resources::NotFoundError => e
        e
      end
    end

    context 'with known session' do
      let(:session_token) { ENV['PARSE_SESSION_TOKEN'] }

      it { is_expected.to be_a(Eezee::Response) }
      it { expect(subject.code).to eq(200) }
      it { expect(subject.body).to match_response_schema('resources/session/find_200') }
    end
  end

  describe '#login!', :vcr do
    subject { described_class.login!(username, password) }

    before { configuration_by_environments! }

    let(:username) { 'muletest@mule.com.br' }

    context 'with invalid password' do
      let(:password) { '123456' }

      it { expect { subject }.to raise_error(Mule::Resources::NotFoundError, "The session can't be found") }
    end

    context 'with valid password' do
      let(:password) { 'mule123' }

      it { is_expected.to be_a(Eezee::Response) }
      it { expect(subject.code).to eq(200) }
      it { expect(subject.body).to match_response_schema('resources/session/login_200') }
    end
  end
end
