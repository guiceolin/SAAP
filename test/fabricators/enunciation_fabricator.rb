Fabricator(:enunciation) do
  name        { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph }
  end_at      { 10.days.from_now }
  crowd
end
