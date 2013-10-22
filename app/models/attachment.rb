class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true
  has_attached_file :document
end
