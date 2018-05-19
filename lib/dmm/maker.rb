require 'dmm/performable'
require 'virtus'

module Dmm
  class Maker
    include Virtus.model
    extend Dmm::Performable
    ready_to_perform :maker, '/MakerSearch'

    attribute :genre_id, Integer
    attribute :name, String
    attribute :ruby, String
    attribute :list_url, String
  end
end
