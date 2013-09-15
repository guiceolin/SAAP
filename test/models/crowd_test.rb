require 'test_helper'
class CrowdTest < ActiveSupport::TestCase

  def test_need_approvation
    assert Crowd.new.need_approvation?
  end

  def test_recipients_wit_professor
    crowd = Fabricate :crowd_with_enrollments, enrollments_count: 4
    assert crowd.recipients_with_professor.count == 4 + 1
    assert crowd.recipients_with_professor.include?(crowd.professor)
  end

  def test_to_s
    crowd = Fabricate :crowd
    assert crowd.to_s == "#{crowd.subject} - #{crowd.name}", "current message: #{crowd.to_s}"
  end

end
