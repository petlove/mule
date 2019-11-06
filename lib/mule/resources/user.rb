# frozen_string_literal: true

module Mule
  module Resources
    class User
      extend Falcon::Client
      extend Handler

      MODEL = :user

      falcon_options :parse, path: 'parse/users'

      def self.find(object_id)
        get(
          suffix: object_id,
          after: ->(response) { handle!(response, MODEL) }
        )
      end
    end
  end
end
