require 'test_helper'
class UserTest < ActiveSupport::TestCase

  def test_unreaded_topics
    professor = Fabricate :professor
    crowd = Fabricate :crowd, professor: professor
    topic_readed = Fabricate :topic, creator: professor, circle: crowd
    topic = Fabricate :topic, creator: professor, circle: crowd
    Fabricate :message, topic: topic, sender: professor
    assert professor.unreaded_topics == [topic], 'returned: ' + professor.unreaded_topics.inspect
    assert !professor.unreaded_topics.include?(topic_readed)
  end

end
