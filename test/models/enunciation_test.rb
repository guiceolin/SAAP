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

  test 'clone enunciation with same crowd' do
    enunciation = Fabricate :enunciation
    Fabricate :group, enunciation: enunciation, students: enunciation.crowd.students
    new_enum = enunciation.clone_for_crowd(enunciation.crowd.id)
    assert new_enum.description == enunciation.description
    assert new_enum.groups.count == enunciation.groups.count, "new: #{new_enum.groups.count} - old: #{enunciation.groups.count}"
    assert new_enum.name.match enunciation.name
    assert new_enum.name.match 'Clone'
    assert new_enum.crowd == nil, "new_enum.croud:" + new_enum.crowd.inspect
  end

  test 'clone enunciation with another crowd' do
    enunciation = Fabricate :enunciation
    Fabricate :group, enunciation: enunciation, students: enunciation.crowd.students
    new_enum = enunciation.clone_for_crowd(Fabricate(:crowd).id)
    assert new_enum.description == enunciation.description
    assert new_enum.groups == []
    assert new_enum.name.match enunciation.name
    assert new_enum.name.match 'Clone'
    assert new_enum.crowd == nil, "new_enum.croud:" + new_enum.crowd.inspect
  end

  test 'clone groups' do
    enun = Fabricate :enunciation
    enun2 = Fabricate :enunciation
    st1 = Fabricate :student
    st2 = Fabricate :student
    st3 = Fabricate :student
    group1 = Fabricate :group, enunciation: enun, students: [st1]
    group2 = Fabricate :group, enunciation: enun, students: [st2, st3]
    enun2.clone_groups(enun)
    assert enun2.groups.count == enun.groups.count
    assert enun2.groups.where(name: group1.name).first.students == [st1]
    assert enun2.groups.where(name: group2.name).first.students - [st2, st3] == []
  end
end
