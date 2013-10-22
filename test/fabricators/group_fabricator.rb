Fabricator(:group) do
  name        { Faker::Lorem.sentence(3) }
  enunciation
  students
end
