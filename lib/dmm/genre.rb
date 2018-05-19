require 'dmm/performable'
require 'virtus'

module Dmm
  class Genre
    include Virtus.model
    extend Dmm::Performable
    ready_to_perform :genre, '/GenreSearch'

    attribute :genre_id, Integer
    attribute :name, String
    attribute :ruby, String
    attribute :list_url, String
  end
end
