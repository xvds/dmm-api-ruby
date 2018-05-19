require 'dmm/performable'
require 'virtus'

module Dmm
  class Site
    include Virtus.model
    extend Dmm::Performable
    ready_to_perform :site, '/FloorList'

    class Service
      include Virtus.model

      class Floor
        include Virtus.model
        attribute :id, Integer
        attribute :name, String
        attribute :code, String
      end

      attribute :name, String
      attribute :code, String
      attribute :floor, Array[Floor]
    end

    attribute :name, String
    attribute :code, String
    attribute :service, Array[Service]
  end
end
