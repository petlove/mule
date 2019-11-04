# frozen_string_literal: true

require 'fileutils'

SETTINGS = 'config/initializers/mule.rb'

namespace :mule do
  desc 'Install Mule'
  task :install do
    create_initializer
  end
end

def create_initializer
  FileUtils.mkdir_p(File.dirname(SETTINGS))
  File.open(SETTINGS, 'w') { |file| file << settings }
end

def settings
  <<~SETTINGS
    # frozen_string_literal: true

    Mule.configure do |config|
      config.url = ENV['PARSE_URL']
      config.application_id = ENV['PARSE_APPLICATION_ID']
      config.rest_api_key = ENV['PARSE_REST_API_KEY']
    end
  SETTINGS
end
