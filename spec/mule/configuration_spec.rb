# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mule::Configuration, type: :model do
  describe '#initialize' do
    subject { described_class.new }

    it do
      is_expected.to have_attributes(
        url: nil,
        application_id: nil,
        rest_api_key: nil
      )
    end
  end
end
