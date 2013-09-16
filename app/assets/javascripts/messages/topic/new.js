$('#messages_topic_circle_id').on('change', function(e){
  $('#circle_type').val($('option:selected').data().type);
});
