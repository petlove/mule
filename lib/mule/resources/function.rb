# frozen_string_literal: true

module Mule
  module Resources
    class Function
      extend Eezee::Client
      extend Handler

      MODEL = :function

      eezee_service :parse, lazy: true
      eezee_request_options path: 'parse/functions/:function_id'

      def self.execute!(function_id, payload)
        post(
          params: { function_id: function_id },
          payload: payload,
          after: ->(_req, res) { handle!(res, MODEL) }
        )
      end
    end
  end
end
