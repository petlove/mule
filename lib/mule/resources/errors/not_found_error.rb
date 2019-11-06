# frozen_string_literal: true

module Mule
  module Resources
    class NotFoundError < StandardError
      attr_accessor :response

      def initialize(response, model)
        @response = response
        super("The #{model} can't be found")
      end
    end
  end
end
