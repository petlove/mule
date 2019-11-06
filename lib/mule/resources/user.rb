# frozen_string_literal: true

module Mule
  module Resources
    class User
      extend Falcon::Client

      falcon_options :parse, path: 'parse/users'

      def self.find(id)
        get(suffix: id)
      end
    end
  end
end
