require 'dmm/performable'
require 'virtus'

module Dmm
  class Series
    include Virtus.model
    extend Dmm::Performable
    ready_to_perform :series, '/SeriesSearch'

    attribute :series_id, Integer
    attribute :name, String
    attribute :ruby, String
    attribute :list_url, String
  end
end
