module ActivityLogHelper

  SUCCESS_ACTIONS = %w(login pub_key_creation)

  def session_activity_action(action)
    if SUCCESS_ACTIONS.include? action
      klass = 'label label-success'
    else
      klass = 'label label-danger'
    end
    content_tag :span, t('activity_log.' + action ), class: klass
  end

end
