module Dmm
  module Performable
    attr_reader :field, :path

    def ready_to_perform(field, path)
      @path = path
      @field = field
    end
  end
end
