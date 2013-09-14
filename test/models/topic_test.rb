require 'test_helper'
class TopicTest < ActiveSupport::TestCase

  def crowd
    @crowd ||= Fabricate :crowd
  end

  def test_automatic_approvation_when_professor
    topic = Fabricate :topic, circle: crowd, creator: crowd.professor
    topic.save
    assert topic.approved
  end

  def test_dont_automatic_approve_when_student_and_crowd
    topic = Fabricate :topic, circle: crowd, creator: Fabricate(:student)
    topic.save
    assert !topic.approved
  end

  def test_automatic_approvation_with_student_and_group
    skip
  end

end
