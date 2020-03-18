# frozen_string_literal: true

require 'spec_helper'

require 'securerandom'

RSpec.describe Mule::Session, type: :model do
  describe '#initialize' do
    subject { described_class.new(params) }
    let(:object_id) { SecureRandom.uuid }
    let(:session_token) { SecureRandom.uuid }
    let(:user_object_id) { SecureRandom.uuid }

    context 'with camelcase params' do
      let(:params) do
        {
          objectId: object_id,
          sessionToken: session_token,
          user: {
            __type: 'Pointer',
            className: '_User',
            objectId: user_object_id
          },
          createdWith: {
            action: 'login',
            authProvider: 'anonymous'
          },
          restricted: false,
          expiresAt: {
            __type: 'Date',
            iso: '2020-10-13T13:03:19.256Z'
          },
          installationId: '123456',
          createdAt: '2019-10-14T13:03:19.256Z',
          updatedAt: '2019-10-14T13:03:19.256Z'
        }
      end

      it do
        is_expected.to have_attributes(
          object_id: object_id,
          session_token: session_token,
          created_at: Time.parse('2019-10-14T13:03:19.256Z'),
          updated_at: Time.parse('2019-10-14T13:03:19.256Z')
        )
      end
      it {
        expect(subject.user).to have_attributes(
          object_id: user_object_id,
          created_at: nil,
          updated_at: nil
        )
      }
    end

    context 'with snack case params' do
      let(:params) do
        {
          object_id: object_id,
          session_token: session_token,
          user: {
            object_id: user_object_id
          },
          created_at: '2019-10-14T13:03:19.256Z',
          updated_at: '2019-10-14T13:03:19.256Z'
        }
      end

      it do
        is_expected.to have_attributes(
          object_id: object_id,
          session_token: session_token,
          created_at: Time.parse('2019-10-14T13:03:19.256Z'),
          updated_at: Time.parse('2019-10-14T13:03:19.256Z')
        )
      end
      it {
        expect(subject.user).to have_attributes(
          object_id: user_object_id,
          created_at: nil,
          updated_at: nil
        )
      }
    end
  end

  describe '#find!', :vcr do
    subject { described_class.find!(object_id) }

    before { configuration_by_environments! }

    context 'with unknown session' do
      let(:object_id) { '123456' }

      it { expect { subject }.to raise_error(Mule::Resources::NotFoundError, "The session can't be found") }
    end

    context 'with known session' do
      let(:object_id) { ENV['PARSE_SESSION_TOKEN'] }

      it do
        is_expected.to have_attributes(
          object_id: ENV['PARSE_SESSION_OBJECT_ID'],
          session_token: ENV['PARSE_SESSION_TOKEN'],
          created_at: Time.parse('2019-10-14T13:03:19.256Z'),
          updated_at: Time.parse('2019-10-14T13:03:19.256Z')
        )
      end
      it do
        expect(subject.user).to have_attributes(
          object_id: ENV['PARSE_USER_OBJECT_ID'],
          created_at: nil,
          updated_at: nil
        )
      end
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

      it do
        is_expected.to have_attributes(
          object_id: nil,
          session_token: 'r:fab1254c3f7428ef49e7d41874cd707c',
          created_at: nil,
          updated_at: nil
        )
      end
      it do
        expect(subject.user).to have_attributes(
          object_id: 'PWVvhOhClw',
          username: 'muletest@mule.com.br',
          full_name: 'muletest',
          created_at: Time.parse('2020-03-17T17:30:24.731Z'),
          updated_at: Time.parse('2020-03-17T17:30:53.419Z')
        )
      end
    end
  end
end
