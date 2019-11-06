# frozen_string_literal: true

require 'securerandom'

RSpec.describe Mule, type: :module do
  it { expect(described_class::VERSION).not_to be_nil }

  describe '.configure' do
    subject do
      described_class.configure do |config|
        config.url = url
        config.application_id = application_id
        config.rest_api_key = rest_api_key
      end
    end

    let(:url) { 'https://parse.parseaccount.com.br/parse/users' }
    let(:application_id) { SecureRandom.uuid }
    let(:rest_api_key) { SecureRandom.uuid }

    before { subject }

    it do
      expect(described_class.configuration).to have_attributes(
        url: url,
        application_id: application_id,
        rest_api_key: rest_api_key
      )
    end
  end

  describe '.configuration' do
    subject { described_class.configuration }

    it { is_expected.to be_a(described_class::Configuration) }
  end
end
