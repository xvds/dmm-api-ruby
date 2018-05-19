require 'dmm/performable'
require 'virtus'

module Dmm
  class Author
    include Virtus.model
    extend Dmm::Performable
    ready_to_perform :author, '/AuthorSearch'

    attribute :author_id, Integer
    attribute :name, String
    attribute :ruby, String
    attribute :list_url, String
  end
end
