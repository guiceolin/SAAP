require 'test_helper'
class StudentTest < ActiveSupport::TestCase

  def test_require_approvation
    assert Student.new.need_approvation?
  end

  def test_circles
    student = Fabricate :student
    crowd = Fabricate :crowd
    Fabricate :enrollment, student: student, crowd: crowd
    assert student.circles.count == 1
    assert student.circles.include?(crowd)
  end

end
