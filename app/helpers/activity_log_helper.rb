module ActivityLogHelper

  def session_activity_action(action)
    if action == 'login'
      klass = 'label label-success'
    else
      klass = 'label label-danger'
    end
    content_tag :span, t('activity_log.' + action ), class: klass
  end
end
