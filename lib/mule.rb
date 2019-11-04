# frozen_string_literal: true

require 'mule/version'

module Mule
  require 'pitbull/railtie' if defined?(Rails)
end
