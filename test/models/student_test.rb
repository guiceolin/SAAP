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

  def test_topics
    student = Fabricate :student
    crowd = Fabricate :crowd
    Fabricate :enrollment, crowd: crowd, student: student
    crowd_topics = []
    crowd_topics_num = 3.times { crowd_topics << Fabricate(:topic, circle: crowd, creator: crowd.professor) }
    unapproved_topics = []
    unapproved_topics_count = 2.times { unapproved_topics << Fabricate(:topic, circle: crowd, creator: student) }
    assert student.topics.count == crowd_topics_num + unapproved_topics_count, "count: #{student.topics.count}"
    assert student.topics == (crowd_topics + unapproved_topics).sort_by(&:updated_at).reverse!
  end

end
