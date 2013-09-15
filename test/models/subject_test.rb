require 'test_helper'
class SubjectTest < ActiveSupport::TestCase

  def test_to_s
    subject = Fabricate :subject
    assert subject.to_s == subject.name, "current to_s: #{subject.to_s}"
  end

end
