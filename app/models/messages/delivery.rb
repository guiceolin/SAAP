class Messages::Delivery < ActiveRecord::Base
  require 'soft_destroy'
  include SoftDestroy
  belongs_to :message
  belongs_to :recipient, class_name: 'User'

  validates :recipient, :message, :presence => true
end
