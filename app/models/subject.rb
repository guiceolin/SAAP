class Subject < ActiveRecord::Base
  include Importable
  validates :name, :description, presence: true
  validates :code, presence: true, uniqueness: true

  importable do |arry|
    raise Importer::InvalidFormatException.new if arry.size != 3
    attr = {}
    attr[:code], attr[:name], attr[:description] = arry
    create(attr)
  end

end
