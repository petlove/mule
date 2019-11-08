# frozen_string_literal: true

module Mule
  class Session < Base
    ACCESSORS = %i[object_id user session_token created_at updated_at].freeze

    attr_accessor(*ACCESSORS)

    def initialize(params = {})
      attributes!(params, ACCESSORS).then { |attributes| build_user!(attributes[:user]) }
    end

    def self.find!(object_id)
      new(Resources::Session.find!(object_id).body)
    end

    private

    def build_user!(user)
      @user = User.new(user) if user
    end
  end
end
