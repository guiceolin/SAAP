(function(){
  $('a.clone-modal').on('click', function(e){
    origin_id = $(this).data('id');
    $('form', '#myModal').attr('action',this.href);
    $("#clone_enunciation_origin_id").val(origin_id);
    $("#myModal").modal();
    return false;
  });
})();
