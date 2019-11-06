# frozen_string_literal: true

require 'falcon'
require 'mule/version'
require 'mule/configuration'
require 'mule/resources/user'

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
