# frozen_string_literal: true

require 'eezee'
require 'mule/version'
require 'mule/configuration'
require 'mule/resources/handler'
require 'mule/resources/user'
require 'mule/resources/session'
require 'mule/resources/function'
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
