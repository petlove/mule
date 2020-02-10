# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mule::Resources::Function, type: :model do
  describe '#execute!', :vcr do
    subject { described_class.execute!(function_id, payload) }

    before { configuration_by_environments! }

    let(:payload) do
      {
        userId: 'n0xjdsdxRNasaIK2a',
        credit: 25,
        clientName: 'Lincoln Rodrigues'
      }
    end

    context 'with invalid function id' do
      let(:function_id) { 'unknown_function_id' }

      it { expect { subject }.to raise_error(Mule::Resources::NotFoundError) }
    end

    context 'with valid function id' do
      let(:function_id) { 'notifyUseOfPetlovePromocode' }

      before { subject }

      it { expect(subject.body).to eq(result: 1) }
    end
  end
end
