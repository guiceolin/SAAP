Fabricator :subject do
  name { Faker::Lorem.characters(15) }
  code { Faker::Lorem.characters(8) }
  description { Faker::Lorem.sentence }
end
