# frozen_string_literal: true

require 'time'

module Mule
  class Base
    class << self
      def normalize(params)
        params.each_with_object({}) { |hash, obj| obj[to_snake(hash[0]).to_sym] = hash[1] }
      end

      private

      def to_snake(value)
        value.to_s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
             .gsub(/([a-z\d])([A-Z])/, '\1_\2')
             .downcase
      end
    end

    def attributes!(params, accessors)
      self
        .class
        .normalize(params)
        .tap { build_accessors!(_1, accessors) }
        .tap { timestamps! }
    end

    private

    def timestamps!
      @created_at = build_time(@created_at)
      @updated_at = build_time(@updated_at)
    end

    def build_accessors!(snaked_params, accessors)
      snaked_params.slice(*accessors)
                   .each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def build_time(value)
      Time.parse(value) if value
    end
  end
end
