json.messages @messages do |msg|
  json.avatar_url gravatar_url_for(msg.sender)
  json.sender do
    json.name msg.sender.name
  end
  json.created_at time_ago_in_words msg.created_at
  json.body msg.body
end
