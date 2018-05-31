module Dmm
  class Response
    attr_reader :request, :result, :elements

    def initialize(body, klass)
      @request = Request.new(body[:request])
      @result = Result.new(body[:result])
      @elements = if @result.send(klass.field).nil?
                    []
                  else
                    @result.send(klass.field).map { |element| klass.new(element) }
                  end
    end

    def has_next?
      !meta[:first_position].nil? &&
        meta[:first_position] + meta[:result_count] - 1 < meta[:total_count]
    end

    def next_option
      return {} if meta[:first_position].nil?
      params = request.parameters.dup
      params[:offset] ||= 1
      params[:offset] = params[:offset].to_i
      params[:offset] += meta[:result_count].to_i
      params
    end

    def meta
      result.meta
    end

    def floor
      result.floor
    end

    class Request
      attr_reader :parameters

      def initialize(request)
        @parameters = request[:parameters]
      end
    end

    class Result
      attr_reader :status, :result_count, :total_count, :first_position,
                  :site_name, :site_code, :service_name, :service_code, :floor_id, :floor_name, :floor_code,
                  :items, :site, :actress, :genre, :series, :maker, :author

      def initialize(result)
        result.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def meta
        {
          status: status,
          result_count: result_count,
          total_count: total_count.to_i,
          first_position: first_position
        }
      end

      def floor
        {
          site_name: site_name,
          site_code: site_code,
          service_name: service_name,
          service_code: service_code,
          floor_id: floor_id,
          floor_name: floor_name,
          floor_code: floor_code
        }
      end
    end

    private

    def respond_to_missing?(method_name, include_private = false)
      elements.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      if elements.respond_to?(method_name)
        return elements.send(method_name, *args, &block)
      end
      super
    end
  end
end
