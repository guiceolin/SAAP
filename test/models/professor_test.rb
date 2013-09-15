require 'test_helper'
class ProfessorTest < ActiveSupport::TestCase
  def test_needs_approvation
    assert !Professor.new.need_approvation?
  end

  def test_circles
    professor = Fabricate :professor
    crowd = Fabricate :crowd, professor: professor
    assert professor.circles.count == 1
    assert professor.circles.include?(crowd)
  end

end
