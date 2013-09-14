Fabricator :crowd do
  name { Faker::Lorem.characters(15) }
  semester { [1,2].sample }
  year { 2010 + rand(10) }
  code { Faker::Lorem.characters(8) }
  subject
  professor
end

Fabricator :crowd_with_enrollments, from: :crowd do
  transient enrollments_count: 3
  after_build do |crowd, transients|
    transients[:enrollments_count].times { Fabricate :enrollment, crowd: crowd }
  end
end
