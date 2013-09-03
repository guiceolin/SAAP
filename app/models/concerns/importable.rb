require 'csv'
module Importable
  extend ActiveSupport::Concern

  module ClassMethods
    def importable(&block)
      @importable_block = block
    end

    def import(file)
      ::CSV.foreach(file) do |row|
        @importable_block.call row
      end
    end

  end

  class InvalidDataException < Exception
  end
end

