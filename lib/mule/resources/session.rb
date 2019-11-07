# frozen_string_literal: true

module Mule
  module Resources
    class Session
      extend Falcon::Client
      extend Handler

      MODEL = :session

      falcon_options :parse, path: 'parse/sessions'

      def self.find(session_token)
        get(
          suffix: 'me',
          after: ->(response) { handle!(response, MODEL) },
          merge_in_headers: { 'X-Parse-Session-Token' => session_token }
        )
      end
    end
  end
end
