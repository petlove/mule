# frozen_string_literal: true

require 'mule/version'
require 'mule/configuration'

module Mule
  require 'mule/railtie' if defined?(Rails)

  def self.configure
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
