class GcalCalendarCreateWorker < GcalWorker
  def perform(user_id)
    user = User.find(user_id)
    user.gcalendar.persist
    user.save!
  end
end
