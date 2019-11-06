# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mule::Resources::User, type: :model do
  describe '#find', :vcr do
    subject { described_class.find(user_id) }

    before { configuration_by_environments! }

    context 'with unknown user' do
      let(:user_id) { '123456' }

      it { expect { subject }.to raise_error(Falcon::Error) }
      it { expect(rescue_unknown_user_error.response.code).to eq(404) }
      it { expect(rescue_unknown_user_error.response.body).to match_response_schema('resources/user/find_404') }

      def rescue_unknown_user_error
        subject
      rescue Falcon::Error => e
        e
      end
    end

    context 'with known user' do
      let(:user_id) { ENV['PARSE_USER_ID'] }

      it { is_expected.to be_a(Falcon::Response) }
      it { expect(subject.code).to eq(200) }
      it { expect(subject.body).to match_response_schema('resources/user/find_200') }
    end
  end
end
