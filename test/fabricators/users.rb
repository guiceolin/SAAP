Fabricator :user do
  username  { Faker::Internet.user_name }
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password "q1w2e3r4"
  password_confirmation 'q1w2e3r4'
end

Fabricator :professor, from: :user do
  type 'Professor'
end

Fabricator :student, from: :user do
  type 'Student'
end
