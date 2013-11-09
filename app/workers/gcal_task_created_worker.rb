class GcalTaskCreatedWorker < GcalWorker

  def perform(gtask_id)
    gtask = Gtask.find(gtask_id)
    if gtask.oauth_authenticated?
      event = gtask.gcalendar.events.add(summary: gtask.description,
                                start: gtask.real_start_date,
                                end: gtask.real_end_date)
      gtask.gevent_id = event.id
      gtask.save!
    end
  end
end
