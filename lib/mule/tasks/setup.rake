# frozen_string_literal: true

require 'fileutils'

FALCON_INITILIAZER_FILE = 'config/initializers/mule.rb'

namespace :mule do
  desc 'Install Mule'
  task :install do
    create_initializer
  end
end

def create_initializer
  FileUtils.mkdir_p(File.dirname(FALCON_INITILIAZER_FILE))
  File.open(FALCON_INITILIAZER_FILE, 'w') { |file| file << settings }
end

def settings
  <<~FALCON_INITILIAZER_FILE
    # frozen_string_literal: true

    Mule.configure do |config|
      config.url = ENV['PARSE_URL']
      config.application_id = ENV['PARSE_APPLICATION_ID']
      config.rest_api_key = ENV['PARSE_REST_API_KEY']
    end
  FALCON_INITILIAZER_FILE
end
