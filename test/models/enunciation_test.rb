require 'test_helper'

class EnunciationTest < ActiveSupport::TestCase

  def test_if_have_name_description_end_at
    name = "name"
    description = 'Description'
    end_at = 2.day.from_now
    enunciation = Fabricate :enunciation, name: name, description: description, end_at: end_at
    assert enunciation.name == name
    assert enunciation.description == description
    assert enunciation.end_at = end_at
  end

  test "finish date is in the future or today" do
    enun = Fabricate.build :enunciation, end_at: 1.day.ago
    assert enun.valid? == false, "finishd date cannot be in past"
    enun = Fabricate.build :enunciation, end_at: Date.today
    assert enun.valid?, "finish must be today or future"
    enun = Fabricate.build :enunciation, end_at: 1.day.from_now
    assert enun.valid?, "finish date must be today or future"
  end

  test 'ungrouped users' do
    crowd = Fabricate :crowd_with_enrollments
    ungrouped_students = crowd.students
    grouped_student = ungrouped_students.shift
    enun = Fabricate :enunciation, crowd: crowd
    Fabricate :group, enunciation: enun, students: [grouped_student]
    assert enun.ungrouped_students, ungrouped_students
  end

end
