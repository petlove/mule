# frozen_string_literal: true

require 'mule/resources/errors/not_found_error'

module Mule
  module Resources
    module Handler
      NOT_FOUND_RESPOPNSE_CODE = 404

      def handle!(response, model)
        handler_error!(response, model)
      end

      private

      def handler_error!(response, model)
        return if response.success?

        handle_not_found!(response, model)
      end

      def handle_not_found!(response, model)
        return unless response.code == NOT_FOUND_RESPOPNSE_CODE

        raise NotFoundError.new(response, model)
      end
    end
  end
end
