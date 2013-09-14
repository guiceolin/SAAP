Fabricator :message, class_name: 'Messages::Message' do
  topic
  sender { Fabricate :student }
  body { Faker::Lorem.paragraphs }
end
