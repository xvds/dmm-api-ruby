module Dmm
  module Configurable
    attr_accessor :api_id, :affiliate_id, :user_agent, :timeouts, :debug

    class << self
      def keys
        @keys ||= %i[
          api_id
          affiliate_id
          user_agent
          timeouts
          debug
        ]
      end
    end

    def configure
      yield self
    end

    def same_options?(opts)
      opts.hash == options.hash
    end

    private

    def options
      Hash[Dmm::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end
