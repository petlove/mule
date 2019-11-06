# frozen_string_literal: true

require 'bundler/setup'
require 'pry'
require 'dotenv'
require 'awesome_print'
require 'support/configs/simple_cov_config'
require 'support/configs/vcr_config'
require 'support/configs/json_matchers_config'
require 'support/helpers/configuration_helper'

SimpleCovConfig.configure

require 'mule'

Dotenv.load('.env.test')
VCRConfig.configure
JsonMatchersConfig.configure

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ConfigurationHelper
end
