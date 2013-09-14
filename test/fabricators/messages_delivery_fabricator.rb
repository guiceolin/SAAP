Fabricator('Messages::Delivery') do
  message
  recipient { Fabricate :student }
  readed    false
end
