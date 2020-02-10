# frozen_string_literal: true

require 'mule/resources/errors/not_found_error'

module Mule
  module Resources
    module Handler
      NOT_FOUND_RESPONSE_CODE = 404
      BAD_REQUEST_RESPONSE_CODE = 400
      INVALID_REQUEST_RESPONSE_CODE = 400

      def handle!(response, model)
        handler_error!(response, model)
      end

      private

      def handler_error!(response, model)
        return if response.success?

        handle_bad_request!(response, model)
        handle_not_found!(response, model)
      end

      def handle_bad_request!(response, model)
        raise_error(NotFoundError, BAD_REQUEST_RESPONSE_CODE, response, model) if model == :session
        raise_error(NotFoundError, INVALID_REQUEST_RESPONSE_CODE, response, model) if model == :function
      end

      def handle_not_found!(response, model)
        raise_error(NotFoundError, NOT_FOUND_RESPONSE_CODE, response, model)
      end

      def raise_error(error, code, response, model)
        return unless response.code == code

        raise error.new(response, model)
      end
    end
  end
end
