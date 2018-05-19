require 'dmm/performable'
require 'virtus'

module Dmm
  class Item
    include Virtus.model
    extend Dmm::Performable
    ready_to_perform :items, '/ItemList'

    class Review
      include Virtus.model
      attribute :count, Integer
      attribute :average, Decimal
    end

    class ImageUrl
      include Virtus.model
      attribute :list, String
      attribute :small, String
      attribute :large, String
    end

    class SampleImageUrl
      include Virtus.model

      class SampleS
        include Virtus.model
        attribute :image, Array[String]
      end

      attribute :sample_s, SampleS
    end

    class SampleMovieUrl
      include Virtus.model
      attribute :size_476_306, String
      attribute :size_560_360, String
      attribute :size_644_414, String
      attribute :size_720_480, String
      attribute :pc_flag, Integer
      attribute :sp_flag, Integer
    end

    class Prices
      include Virtus.model

      class Deliveries
        include Virtus.model

        class Delivery
          include Virtus.model
          attribute :type, String
          attribute :price, Integer
        end

        attribute :derivery, Array[Delivery]
      end

      attribute :price, String
      attribute :deliveries, Deliveries
    end

    class ItemInfo
      include Virtus.model

      class Genre
        include Virtus.model
        attribute :id, Integer
        attribute :name, String
      end

      class Series
        include Virtus.model
        attribute :id, Integer
        attribute :name, String
      end

      class Maker
        include Virtus.model
        attribute :id, Integer
        attribute :name, String
      end

      class Actress
        include Virtus.model
        attribute :id, String
        attribute :name, String
      end

      class Director
        include Virtus.model
        attribute :id, String
        attribute :name, String
      end

      class Label
        include Virtus.model
        attribute :id, Integer
        attribute :name, String
      end

      attribute :genre, Array[Genre]
      attribute :series, Array[Series]
      attribute :maker, Array[Maker]
      attribute :actress, Array[Actress]
      attribute :director, Array[Director]
      attribute :label, Array[Label]
    end

    attribute :service_code, String
    attribute :service_name, String
    attribute :floor_code, String
    attribute :floor_name, String
    attribute :content_id, String
    attribute :product_id, String
    attribute :title, String
    attribute :volume, Integer
    attribute :review, Review
    attribute :url, String
    attribute :url_sp, String
    attribute :affiliate_url, String
    attribute :affiliate_url_sp, String
    attribute :image_url, ImageUrl
    attribute :sample_image_url, SampleImageUrl
    attribute :sample_movie_url, SampleMovieUrl
    attribute :prices, Prices
    attribute :date, Time
    attribute :iteminfo, ItemInfo
  end
end
