# frozen_string_literal: true

module Mule
  module Resources
    class User
      extend Eezee::Client
      extend Handler

      MODEL = :user

      eezee_service :parse, lazy: true
      eezee_request_options path: 'parse/users/:user_id'

      def self.find!(user_id)
        get(
          params: { user_id: user_id },
          after: ->(_req, res) { handle!(res, MODEL) }
        )
      end
    end
  end
end
