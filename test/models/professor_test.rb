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

  def test_topics
    professor = Fabricate :professor
    crowd = Fabricate :crowd, professor: professor
    topics = []
    topics_count = 4.times { topics << Fabricate(:topic, circle: crowd, creator: professor) }
    assert professor.topics.count == topics_count, "count: #{professor.topics.count}"
    assert professor.topics == topics.sort_by(&:updated_at).reverse!
  end

end
