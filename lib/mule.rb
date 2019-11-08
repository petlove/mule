# frozen_string_literal: true

require 'falcon'
require 'mule/version'
require 'mule/configuration'
require 'mule/resources/handler'
require 'mule/resources/user'
require 'mule/resources/session'
require 'mule/base'
require 'mule/user'
require 'mule/session'

module Mule
  require 'mule/railtie' if defined?(Rails)

  def self.configure
    yield(configuration)
    configuration.build_options!
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
