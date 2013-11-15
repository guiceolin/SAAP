class Attachment < ActiveRecord::Base
  require 'soft_destroy'
  include SoftDestroy
  belongs_to :attachable, polymorphic: true
  has_attached_file :document
end
