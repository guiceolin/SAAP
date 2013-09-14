Fabricator :topic, class_name: 'Messages::Topic' do
  subject { Faker::Lorem.sentence }
  creator { Fabricate :student }
  circle { Fabricate :crowd }
end
