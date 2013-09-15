class Subject < ActiveRecord::Base
  include Importable
  validates :name, :description, presence: true
  validates :code, presence: true, uniqueness: true

  has_many :crowds, dependent: :restrict_with_error

  def to_s
    name
  end

  importable do |arry|
    raise Importable::InvalidFormatException.new if arry.size != 3
    attr = {}
    attr[:code], attr[:name], attr[:description] = arry
    create(attr)
  end

end
