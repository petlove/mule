# frozen_string_literal: true

require 'time'

module Mule
  class User
    ACCESSORS = %i[object_id username created_at updated_at full_name].freeze

    attr_accessor(*ACCESSORS)

    def initialize(params = {})
      params.each_with_object({}) { |hash, obj| obj[to_snake(hash[0]).to_sym] = hash[1] }
            .slice(*ACCESSORS)
            .each { |key, value| instance_variable_set("@#{key}", value) }

      @created_at = build_time(@created_at)
      @updated_at = build_time(@updated_at)
    end

    def self.find!(object_id)
      new(Resources::User.find(object_id).body)
    end

    private

    def to_snake(value)
      value.to_s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
           .gsub(/([a-z\d])([A-Z])/, '\1_\2')
           .downcase
    end

    def build_time(value)
      Time.parse(value) if value
    end
  end
end
