# frozen_string_literal: true

module Mule
  module Resources
    class Session
      extend Eezee::Client
      extend Handler

      MODEL = :session

      eezee_service :parse, lazy: true
      eezee_request_options path: 'parse/:session_path'

      def self.find!(session_token)
        get(
          params: { session_path: 'sessions/me' },
          before: ->(req) { req.headers.merge!('X-Parse-Session-Token' => session_token) },
          after: ->(_req, res) { handle!(res, MODEL) }
        )
      end

      def self.login!(username, password)
        get(
          params: { session_path: 'login' },
          payload: { username: username, password: password },
          after: ->(_req, res) { handle!(res, MODEL) }
        )
      end
    end
  end
end
