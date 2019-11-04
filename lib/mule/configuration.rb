# frozen_string_literal: true

module Mule
  class Configuration
    SETTINGS = %i[url application_id rest_api_key].freeze

    attr_accessor(*SETTINGS)

    def initialize
      SETTINGS.each { |key, _| instance_variable_set("@#{key}", nil) }
    end
  end
end
