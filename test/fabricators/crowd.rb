Fabricator :crowd do
  name { Faker::Lorem.characters(15) }
  semester { [1,2].sample }
  year { 2010 + rand(10) }
  code { Faker::Lorem.characters(8) }
  subject
  professor
end

Fabricator :crowd_with_enrollments, from: :crowd do
  after_build do |crowd|
    3.times { Fabricate :enrollment, crowd: crowd }
  end
end
