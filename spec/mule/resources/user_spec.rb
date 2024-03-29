# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mule::Resources::User, type: :model do
  describe '#find', :vcr do
    subject { described_class.find!(user_object_id, ENV['PARSE_SESSION_TOKEN']) }

    before { configuration_by_environments! }

    context 'with unknown user' do
      let(:user_object_id) { '123456' }

      it { expect { subject }.to raise_error(Mule::Resources::NotFoundError, "The user can't be found") }
      it { expect(rescue_unknown_user_error.response.code).to eq(404) }
      it { expect(rescue_unknown_user_error.response.body).to match_response_schema('resources/user/find_404') }

      def rescue_unknown_user_error
        subject
      rescue Mule::Resources::NotFoundError => e
        e
      end
    end

    context 'with known user' do
      let(:user_object_id) { ENV['PARSE_USER_OBJECT_ID'] }

      it { is_expected.to be_a(Eezee::Response) }
      it { expect(subject.code).to eq(200) }
      it { expect(subject.body).to match_response_schema('resources/user/find_200') }
    end
  end
end
