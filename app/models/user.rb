class User < ActiveRecord::Base
  include Importable

  has_many :deliveries, class_name: 'Messages::Delivery', foreign_key: 'recipient_id'
  has_many :messages, through: :deliveries, class_name: 'Messages::Message'

  validates :name, presence: true
  validates :username, :email, presence: true, uniqueness: true

  def topics
    circles.map(&:topics).flatten.uniq.sort_by(&:updated_at).reverse!
  end

  def unreaded_topics
    deliveries.includes(:message => :topic).where(readed: false).group('messages_topics.id').references(:topic).map(&:message).map(&:topic)
  end

  has_secure_password
end

