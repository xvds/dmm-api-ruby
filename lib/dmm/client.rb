require 'addressable/uri'
require 'http'
require 'dmm/configurable'
require 'dmm/actress'
require 'dmm/item'
require 'dmm/site'
require 'dmm/genre'
require 'dmm/author'
require 'dmm/series'
require 'dmm/maker'
require 'dmm/error'
require 'dmm/response'

module Dmm
  class Client
    include Dmm::Configurable

    BASE_URL = 'https://api.dmm.com/affiliate/v3'.freeze
    USER_AGENT = "DmmRubyGem/#{Dmm::VERSION}".freeze
    PERFORMABLES = [
      Dmm::Item, Dmm::Actress, Dmm::Site,
      Dmm::Genre, Dmm::Author, Dmm::Series, Dmm::Maker
    ].freeze

    def initialize(options = {})
      Dmm::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key] || Dmm.instance_variable_get(:"@#{key}"))
      end
      yield(self) if block_given?
    end

    PERFORMABLES.each do |klass|
      define_method klass.field do |options = {}|
        perform_request klass, options
      end

      define_method "#{klass.field}_uri" do |options = {}|
        build_uri klass.path, options
      end

      define_method "paginate_#{klass.field}" do |options = {}, &block|
        paginate_request klass, options, &block
      end
    end

    def credentials
      {
        api_id: api_id,
        affiliate_id: affiliate_id
      }
    end

    def perform_request(klass, options = {})
      path = klass.path
      uri = Addressable::URI.parse(path.start_with?('http') ? path : BASE_URL + path)
      response = http_client.headers(user_agent: user_agent)
                            .public_send(:get, uri.to_s, params: credentials.merge(options))
      response_body = response.body.empty? ? '' : underscore_and_symbolize_keys!(response.parse)
      fail_or_return_response(response.code, response_body, klass)
    end

    def paginate_request(klass, options = {}, &block)
      path = klass.path
      paginate_count = options.delete(:paginate_count)
      response = perform_request(klass, options)
      yield(response)
      paginate_count -= 1 unless paginate_count.nil?
      if response.has_next? && (paginate_count.nil? || paginate_count > 0)
        paginate_request klass, response.next_option.merge(paginate_count: paginate_count), &block
      end
    end

    def build_uri(path, options = {})
      uri = Addressable::URI.parse(path.start_with?('http') ? path : BASE_URL + path)
      uri.query_values = credentials.merge(options)
      uri.to_s
    end

    private

    def http_client
      client = HTTP
      client = client.timeout(:per_operation, connect: timeouts[:connect], read: timeouts[:read], write: timeouts[:write]) if timeouts
      client
    end

    def fail_or_return_response(code, body, klass)
      raise Dmm::Error::ServerError, body if code >= 500
      raise Dmm::Error::ClientError, body if code >= 400
      Response.new body, klass
    end

    def underscore_and_symbolize_keys!(object)
      if object.is_a?(Array)
        object.each_with_index do |val, index|
          object[index] = underscore_and_symbolize_keys!(val)
        end
      elsif object.is_a?(Hash)
        object.dup.each_key do |key|
          object[underscore(key).to_sym] = underscore_and_symbolize_keys!(object.delete(key))
        end
      end
      object
    end

    def underscore(camel_cased_word)
      return camel_cased_word unless /[A-Z-]|::/.match?(camel_cased_word)
      word = camel_cased_word.to_s.gsub('::'.freeze, '/'.freeze)
      acronyms_underscore_regex = /(?:(?<=([A-Za-z\d]))|\b)((?=a)b)(?=\b|[^a-z])/
      word.gsub!(acronyms_underscore_regex) { "#{Regexp.last_match(1) && '_'.freeze}#{Regexp.last_match(2).downcase}" }
      word.gsub!(/([A-Z\d]+)([A-Z][a-z])/, '\1_\2'.freeze)
      word.gsub!(/([a-z\d])([A-Z])/, '\1_\2'.freeze)
      word.tr!('-'.freeze, '_'.freeze)
      word.downcase!
      word
    end
  end
end
