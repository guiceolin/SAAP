require 'test_helper'
class UserTest < ActiveSupport::TestCase

  def test_unreaded_topics
    professor = Fabricate :professor
    crowd = Fabricate :crowd, professor: professor
    topic_readed = Fabricate :topic, creator: professor, circle: crowd
    unreaded_topic = Fabricate :topic, creator: professor, circle: crowd
    other_unreaded_topic = Fabricate :topic, creator: professor, circle: crowd
    Delorean.time_travel_to (3.minutes.from_now) { Fabricate :message, topic: unreaded_topic, sender: professor }
    Delorean.time_travel_to (4.minutes.from_now) { Fabricate :message, topic: other_unreaded_topic, sender: professor }
    assert professor.unreaded_topics == [other_unreaded_topic, unreaded_topic].sort_by(&:updated_at).reverse!, 'returned: ' + professor.unreaded_topics.inspect
    assert !professor.unreaded_topics.include?(topic_readed)
  end

end
