require 'dmm/performable'
require 'virtus'

module Dmm
  class Actress
    include Virtus.model
    extend Dmm::Performable
    ready_to_perform :actress, '/ActressSearch'

    class ImageUrl
      include Virtus.model

      attribute :small, String
      attribute :large, String
    end

    class ListUrl
      include Virtus.model

      attribute :digital, String
      attribute :monthly, String
      attribute :ppm, String
      attribute :mono, String
      attribute :rental, String
    end

    attribute :id, Integer
    attribute :name, String
    attribute :ruby, String
    attribute :bust, String
    attribute :cup, String
    attribute :waist, String
    attribute :hip, String
    attribute :height, String
    attribute :birthday, Date
    attribute :blood_type, String
    attribute :hobby, String
    attribute :prefectures, String
    attribute :image_url, ImageUrl
    attribute :list_url, ListUrl
  end
end
