# frozen_string_literal: true

module Mule
  module Resources
    class Session
      extend Eezee::Client
      extend Handler

      MODEL = :session

      eezee_service :parse, lazy: true
      eezee_request_options path: 'parse/sessions/:session_id'

      def self.find!(session_token)
        get(
          params: { session_id: 'me' },
          before: ->(req) { req.headers.merge!('X-Parse-Session-Token' => session_token) },
          after: ->(_req, res) { handle!(res, MODEL) }
        )
      end
    end
  end
end
