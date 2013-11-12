$(document).ready(function(){

  /* ---------- Acivate Functions ---------- */
  template_functions();
  widthFunctions();

});

/* ---------- Numbers Sepparator ---------- */

function numberWithCommas(x) {
  x = x.toString();
  var pattern = /(-?\d+)(\d{3})/;
  while (pattern.test(x))
    x = x.replace(pattern, "$1.$2");
  return x;
}

/* ---------- Template Functions ---------- */

function template_functions(){

  /* ---------- Disable moving to top ---------- */
  $('a[href="#"][data-top!=true]').click(function(e){
    e.preventDefault();
  });

  /* ---------- Datapicker ---------- */
  $('.datepicker').datepicker();


  /* ---------- Uniform ---------- */
  $("input:checkbox, input:radio, input:file").not('[data-no-uniform="true"],#uniform-is-ajax').uniform();

  /* ---------- Choosen ---------- */
  $('[data-rel="chosen"],[rel="chosen"]').chosen();

  /* ---------- Tooltip ---------- */
  $('[rel="tooltip"],[data-rel="tooltip"]').tooltip({"placement":"bottom",delay: { show: 400, hide: 200 }});

  /* ---------- Popover ---------- */
  $('[rel="popover"],[data-rel="popover"]').popover();

  /* ---------- Fullscreen ---------- */
  $('#toggle-fullscreen').button().click(function () {
    var button = $(this), root = document.documentElement;
    if (!button.hasClass('active')) {
      $('#thumbnails').addClass('modal-fullscreen');
      if (root.webkitRequestFullScreen) {
        root.webkitRequestFullScreen( window.Element.ALLOW_KEYBOARD_INPUT);
      } else if (root.mozRequestFullScreen) {
        root.mozRequestFullScreen();
      }
    } else {
      $('#thumbnails').removeClass('modal-fullscreen');
      (document.webkitCancelFullScreen ||
       document.mozCancelFullScreen ||
       $.noop).apply(document);
    }
  });

  /* ---------- Datable ---------- */
  $('.datatable').dataTable({
    "sDom": "<'row'<'col-lg-6'l><'col-lg-6'f>r>t<'row'<'col-lg-12'i><'col-lg-12 center'p>>",
    "sPaginationType": "bootstrap",
    "oLanguage": {
      "sLengthMenu": "_MENU_ records per page"
    }
  } );

  $('.btn-close').click(function(e){
    e.preventDefault();
    $(this).parent().parent().parent().fadeOut();
  });
  $('.btn-minimize').click(function(e){
    e.preventDefault();
    var $target = $(this).parent().parent().next('.box-content');
    if($target.is(':visible')) $('i',$(this)).removeClass('icon-chevron-up').addClass('icon-chevron-down');
    else 					   $('i',$(this)).removeClass('icon-chevron-down').addClass('icon-chevron-up');
    $target.slideToggle();
  });
  $('.btn-setting').click(function(e){
    e.preventDefault();
    $('#myModal').modal('show');
  });

  /* ---------- Page width functions ---------- */

  $(window).bind("resize", widthFunctions);
}

function widthFunctions(e) {

  if($('.timeline')) {

    $('.timeslot').each(function(){

      var timeslotHeight = $(this).find('.task').outerHeight();

      $(this).css('height',timeslotHeight);

    });

  }

  var sidebarLeftHeight = $('#sidebar-left').outerHeight();
  var contentHeight = $('#content').height();
  var contentHeightOuter = $('#content').outerHeight();

  var winHeight = $(window).height();
  var winWidth = $(window).width();

  if (winWidth > 767) {

    if (sidebarLeftHeight > contentHeight) {

      $('#content').css("height",sidebarLeftHeight);

    } else {

      $('#content').css("height","auto");

    }

    $('#white-area').css('height',contentHeightOuter);

  } else {

    $('#white-area').css('height','auto');

  }


  if (winWidth < 768) {

    if($('.chat-full')) {

      $('.chat-full').each(function(){

        $(this).addClass('alt');

      });

    }

  } else {

    if($('.chat-full')) {

      $('.chat-full').each(function(){

        $(this).removeClass('alt');

      });

    }

  }
}
