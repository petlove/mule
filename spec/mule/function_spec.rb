# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mule::Function, type: :model do
  describe '#initialize' do
    subject { described_class.new(params) }

    let(:params) do
      {
        id: 'notifyUseOfPetlovePromocode',
        payload: {
          userId: 'n0xjdsdxRNasaIK2a',
          credit: 25,
          clientName: 'Lincoln Rodrigues'
        }
      }
    end

    it do
      is_expected.to have_attributes(
        id: 'notifyUseOfPetlovePromocode',
        payload: {
          userId: 'n0xjdsdxRNasaIK2a',
          credit: 25,
          clientName: 'Lincoln Rodrigues'
        }
      )
    end
  end

  describe '#execute!', :vcr do
    subject { described_class.new(params).execute! }

    before { configuration_by_environments! }

    let(:params) do
      {
        id: id,
        payload: {
          userId: 'n0xjdsdxRNasaIK2a',
          credit: 25,
          clientName: 'Lincoln Rodrigues'
        }
      }
    end

    context 'with invalid function id' do
      let(:id) { 'unknown_function_id' }

      it { expect { subject }.to raise_error(Mule::Resources::NotFoundError) }
    end

    context 'with valid function id' do
      let(:id) { 'notifyUseOfPetlovePromocode' }

      before { subject }

      it { expect(subject.body).to eq(result: 1) }
    end
  end
end
