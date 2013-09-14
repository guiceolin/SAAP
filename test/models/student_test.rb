require 'test_helper'
class StudentTest < ActiveSupport::TestCase

  def test_require_approvation
    assert Student.new.need_approvation?
  end

end
