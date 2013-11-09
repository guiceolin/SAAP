class GcalTaskUpdatedWorker < GcalWorker

  def perform(gtask_id)
    gtask = Gtask.find(gtask_id)
    if gtask.oauth_authenticated?
      event = gtask.gcalendar.events.find(gtask.gevent_id)
      event.start = Gcal::DateTime.new gtask.real_start_date
      event.end = Gcal::DateTime.new gtask.real_end_date
      event.persist
    end
  end
end
