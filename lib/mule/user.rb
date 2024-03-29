# frozen_string_literal: true

module Mule
  class User < Base
    ACCESSORS = %i[object_id username created_at updated_at full_name business_phone1].freeze

    attr_accessor(*ACCESSORS)

    def initialize(params = {})
      attributes!(params, ACCESSORS)
    end

    def self.find!(object_id, vetsmart_session_token)
      new(Resources::User.find!(object_id, vetsmart_session_token).body)
    end
  end
end
