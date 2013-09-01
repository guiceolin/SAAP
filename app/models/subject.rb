class Subject < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :code, presence: true, uniqueness: true

end
