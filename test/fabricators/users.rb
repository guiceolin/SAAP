Fabricator :user do
  username  Fabricate.sequence(:username)
  name { Faker::Name.name }
  email "email#{Fabricate.sequence(:email)}@mail.com"
  password "q1w2e3r4"
  password_confirmation 'q1w2e3r4'
end

Fabricator :professor, from: :user do
  type 'Professor'
end

Fabricator :student, from: :user do
  type 'Student'
end
