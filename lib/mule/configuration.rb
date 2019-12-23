# frozen_string_literal: true

module Mule
  class Configuration
    ACCESSORS = %i[url application_id rest_api_key].freeze

    attr_accessor(*ACCESSORS)

    def initialize
      ACCESSORS.each { |key, _| instance_variable_set("@#{key}", nil) }
    end

    def build_options!
      return unless @url

      Eezee.configure do |config|
        config.add_service :parse,
                           raise_error: true,
                           url: @url,
                           headers: {
                             'Content-Type' => 'application/json',
                             'X-Parse-Application-Id' => @application_id,
                             'X-Parse-REST-API-Key' => @rest_api_key
                           }
      end
    end
  end
end
