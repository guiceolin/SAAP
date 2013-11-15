class Membership < ActiveRecord::Base
  require 'soft_destroy'
  include SoftDestroy
  belongs_to :student
  belongs_to :group
end
