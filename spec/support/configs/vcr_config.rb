# frozen_string_literal: true

require 'vcr'
require 'webmock'

class VCRConfig
  FILTER = %w[
    PARSE_URL
    PARSE_APPLICATION_ID
    PARSE_REST_API_KEY
    PARSE_USER_OBJECT_ID
    PARSE_SESSION_TOKEN
    PARSE_SESSION_OBJECT_ID
  ].freeze

  def self.configure
    VCR.configure do |config|
      config.allow_http_connections_when_no_cassette = false
      config.cassette_library_dir = 'spec/cassettes'
      config.hook_into :webmock
      config.ignore_localhost = true
      config.configure_rspec_metadata!

      FILTER.each do |env|
        config.filter_sensitive_data("ENV[#{env}]") { ENV[env] }
      end
    end
  end
end
