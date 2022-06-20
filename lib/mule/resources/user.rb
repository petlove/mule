# frozen_string_literal: true

module Mule
  module Resources
    class User
      extend Eezee::Client
      extend Handler

      MODEL = :user

      eezee_service :parse, lazy: true
      eezee_request_options path: 'parse/users/:user_id'

      def self.find!(user_id, vetsmart_session_token)
        get(
          params: { user_id: user_id },
          before: ->(req) { req.headers.merge!('X-Parse-Session-Token' => vetsmart_session_token) },
          after: ->(_req, res) { handle!(res, MODEL) }
        )
      end
    end
  end
end
