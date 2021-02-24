# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mule::User, type: :model do
  describe '#initialize' do
    subject { described_class.new(params) }

    context 'with camelcase params' do
      let(:params) do
        {
          objectId: '123456',
          appDC: true,
          username: 'Linqueta',
          createdAt: '2019-10-07T19:34:46.660Z',
          updatedAt: '2019-10-14T13:03:18.917Z',
          businessPhone1: "(11) 99440-1346",
          notificationPrefs: {
            vetsmart_push: true,
            streaming_app: true,
            vetsmart_app: true,
            vetsmart_email: true,
            streaming_email: true,
            streaming_push: true
          },
          specializationList: [],
          fullName: 'Linqueta linqueta',
          countryId: 'BRA',
          termsAndPolicyVersion: '1.0',
          stateId: '',
          occupationId: '',
          weeklyAppointment: nil,
          ACL: {
            :* => {
              read: true
            },
            :uQ0SKvycQS => {
              read: true,
              write: true
            }
          }
        }
      end

      it do
        is_expected.to have_attributes(
          object_id: '123456',
          username: 'Linqueta',
          created_at: Time.parse('2019-10-07T19:34:46.660Z'),
          updated_at: Time.parse('2019-10-14T13:03:18.917Z'),
          full_name: 'Linqueta linqueta',
          business_phone1: "(11) 99440-1346"
        )
      end
    end

    context 'with snack case params' do
      let(:params) do
        {
          object_id: '123456',
          username: 'Linqueta',
          created_at: '2019-10-07T19:34:46.660Z',
          updated_at: '2019-10-14T13:03:18.917Z',
          full_name: 'Linqueta linqueta',
          business_phone1: "(11) 99440-1346"
        }
      end

      it do
        is_expected.to have_attributes(
          object_id: '123456',
          username: 'Linqueta',
          created_at: Time.parse('2019-10-07T19:34:46.660Z'),
          updated_at: Time.parse('2019-10-14T13:03:18.917Z'),
          full_name: 'Linqueta linqueta',
          business_phone1: "(11) 99440-1346"
        )
      end
    end
  end

  describe '#find!', :vcr do
    subject { described_class.find!(object_id) }

    before { configuration_by_environments! }

    context 'with unknown user' do
      let(:object_id) { '123456' }

      it { expect { subject }.to raise_error(Mule::Resources::NotFoundError, "The user can't be found") }
    end

    context 'with known user' do
      let(:object_id) { ENV['PARSE_USER_OBJECT_ID'] }

      it do
        is_expected.to have_attributes(
          object_id: ENV['PARSE_USER_OBJECT_ID'],
          username: 'lincoln.rodrs@gmail.com',
          created_at: Time.parse('2019-10-07T19:34:46.660Z'),
          updated_at: Time.parse('2019-10-14T13:03:18.917Z'),
          full_name: 'lincoln soares '
        )
      end
    end
  end
end
