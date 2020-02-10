# frozen_string_literal: true

module Mule
  class Function < Base
    ACCESSORS = %i[id payload].freeze

    attr_accessor(*ACCESSORS)

    def initialize(params = {})
      attributes!(params, ACCESSORS)
    end

    def execute!
      Resources::Function.execute!(@id, @payload)
    end
  end
end
