# frozen_string_literal: true

module Mule
  class Session < Base
    ACCESSORS = %i[object_id user session_token created_at updated_at].freeze

    attr_accessor(*ACCESSORS)

    def initialize(params = {})
      attributes!(params, ACCESSORS).then { build_user!(_1[:user]) }
    end

    def self.find!(object_id)
      new(Resources::Session.find!(object_id).body)
    end

    def self.login!(username, password)
      Resources::Session
        .login!(username, password)
        .then { normalize(_1.body) }
        .tap  { _1[:user] = _1.slice(:object_id, :username, :created_at, :updated_at, :full_name) }
        .then { _1.slice(:session_token, :user) }
        .then { new(_1) }
    end

    private

    def build_user!(user)
      @user = User.new(user) if user
    end
  end
end
