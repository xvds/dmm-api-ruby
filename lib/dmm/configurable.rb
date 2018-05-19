module Dmm
  module Configurable
    attr_accessor :api_id, :affiliate_id, :user_agent, :timeouts

    class << self
      def keys
        @keys ||= %i[
          api_id
          affiliate_id
          user_agent
          timeouts
        ]
      end
    end

    def configure
      yield self
    end

    # Reset configuration options to default values
    def reset!
      Dmm::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Octokit::Default.options[key])
      end
      self
    end
    alias setup reset!

    def same_options?(opts)
      opts.hash == options.hash
    end

    private

    def options
      Hash[Dmm::Configurable.keys.map { |key| [key, instance_variable_get(:"@#{key}")] }]
    end
  end
end
