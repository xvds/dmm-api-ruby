require 'dmm/client'
require 'dmm/configurable'
require 'dmm/error'
require 'dmm/version'

module Dmm
  class << self
    include Dmm::Configurable

    def client
      return @client if defined?(@client) && @client.same_options?(options)
      @client = Dmm::Client.new(options)
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        return client.send(method_name, *args, &block)
      end
      super
    end
  end
end
