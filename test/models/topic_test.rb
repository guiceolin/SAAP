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
    skip "Implementar quando implementar grupos"
  end

  def test_alwais_include_professor_with_crowd
    topic = Fabricate :topic, circle: Fabricate(:crowd)
    topic.save
    assert topic.include_professor
  end

  def test_recipients_including_professor
    crowd = Fabricate :crowd_with_enrollments, enrollments_count: 3
    topic = Fabricate :topic, circle: crowd
    assert topic.recipients.count == crowd.enrollments.count + 1
  end

  def test_recipient_not_including_professor
    skip 'Caso de um grupo que nao inclua o professor'
  end

  def test_update_at_when_new_message_is_created
    topic = Fabricate :topic
    old_updated_at = topic.updated_at
    Fabricate :message, topic: topic
    topic.reload
    assert old_updated_at != topic.updated_at
  end
end
