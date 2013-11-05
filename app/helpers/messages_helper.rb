module MessagesHelper
  def format_datetime_from_topic(date)
    if date.today?
      time_ago_in_words date
    else
      l(date.to_date)
    end
  end
end
