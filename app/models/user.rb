require 'gcal'
class User < ActiveRecord::Base
  include Importable
  include Gcal

  has_gcalendar summary: 'Teste', access_token: :oauth_access_token, refresh_token: :oauth_refresh_token
  has_many :gtasks, -> { where(deleted_at: nil) }

  has_many :deliveries, -> { where(deleted_at: nil) }, class_name: 'Messages::Delivery', foreign_key: 'recipient_id'
  has_many :messages, through: :deliveries, class_name: 'Messages::Message'
  has_many :pub_keys

  validates :name, presence: true
  validates :username, :email, presence: true, uniqueness: true

  after_create :send_welcome_mail

  def topics
    circles.map(&:topics).flatten.uniq.sort_by(&:updated_at).reverse!
  end

  def approved_topics
    topics.select(&:approved)
  end

  def unapproved_topics
    topics.reject(&:approved).reject(&:reproved)
  end

  def reproved_topics
    topics.select(&:reproved)
  end

  def unreaded_topics
    deliveries.includes(:message => :topic).where(readed: false).group('messages_topics.id').order('messages_topics.updated_at DESC').references(:topic).map(&:message).map(&:topic)
  end

  def pub_key_names
    pub_keys.map(&:name)
  end

  def add_oauth_credentials(credentials)
    self.oauth_access_token = credentials['token']
    self.oauth_refresh_token = credentials['refresh_token']
    self.oauth_expires_in = credentials['expires_in']
    self.save!
  end

  def oauth_authenticated?
    !!(self.oauth_access_token && self.oauth_refresh_token)
  end

  def generate_password_reset_token
    self.password_reset_token = SecureRandom.hex(64)
  end

  has_secure_password

  private

  def send_welcome_mail
    generate_password_reset_token
    UserMailer.welcome_mail(self).deliver
  end
end

