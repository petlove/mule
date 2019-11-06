# frozen_string_literal: true

module ConfigurationHelper
  def configuration_by_environments!
    Falcon.configure do |config|
      config.add :parse,
                 raise_error: true,
                 url: ENV['PARSE_URL'],
                 headers: {
                   'Content-Type' => 'application/json',
                   'X-Parse-Application-Id' => ENV['PARSE_APPLICATION_ID'],
                   'X-Parse-REST-API-Key' => ENV['PARSE_REST_API_KEY']
                 }
    end
  end
end
