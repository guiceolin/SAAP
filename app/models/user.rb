class User < ActiveRecord::Base
  include Importable

  has_many :deliveries, class_name: 'Messages::Delivery', foreign_key: 'recipient_id'
  has_many :messages, through: :deliveries, class_name: 'Messages::Message'
  has_many :topics, through: :messages, class_name: 'Messages::Topic'

  validates :name, presence: true
  validates :username, :email, presence: true, uniqueness: true

  has_secure_password
end

