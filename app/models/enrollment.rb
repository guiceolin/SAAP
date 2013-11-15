class Enrollment < ActiveRecord::Base
  require 'soft_destroy'
  include SoftDestroy
  belongs_to :student
  belongs_to :crowd
end
