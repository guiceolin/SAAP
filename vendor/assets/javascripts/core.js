/* -------------------- Check Browser --------------------- */
function browser() {
	
	var isOpera = !!(window.opera && window.opera.version);  // Opera 8.0+
	var isFirefox = testCSS('MozBoxSizing');                 // FF 0.8+
	var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
	    // At least Safari 3+: "[object HTMLElementConstructor]"
	var isChrome = !isSafari && testCSS('WebkitTransform');  // Chrome 1+
	//var isIE = /*@cc_on!@*/false || testCSS('msTransform');  // At least IE6

	function testCSS(prop) {
	    return prop in document.documentElement.style;
	}
	
	if (isOpera) {
		
		return false;
		
	}else if (isSafari || isChrome) {
		
		return true;
		
	} else {
		
		return false;
		
	}
	
}
/* ---------- Placeholder Fix for IE ---------- */
jQuery(document).ready(function($){
	$('input, textarea').placeholder();
});

/* ---------- Auto Height texarea ---------- */
jQuery(document).ready(function($){
    $('textarea').autosize();   
});

/* ---------- Delete Comment ---------- */
jQuery(document).ready(function($){
    $('.discussions').find('.delete').click(function(){
		
		$(this).parent().fadeTo("slow", 0.00, function(){ //fade
			$(this).slideUp("slow", function() { //slide up
		    	$(this).remove(); //then remove from the DOM
		    });
		});
	
	});
});

/* ---------- IE8 list style hack (:nth-child(odd)) ---------- */
jQuery(document).ready(function($){
	
	if($('.messagesList').width()) {
		
		if(jQuery.browser.version.substring(0, 2) == "8.") {

			$('ul.messagesList li:nth-child(2n+1)').addClass('odd');
			
		}
		
	}
	
});


/* ---------- Check Retina ---------- */
function retina(){
	
	retinaMode = (window.devicePixelRatio > 1);
	
	return retinaMode;
	
}

jQuery(document).ready(function($){
	
	/* ---------- Add class .active to current link  ---------- */
	$('ul.main-menu li a').each(function(){
		
			if($($(this))[0].href==String(window.location)) {
				
				$(this).parent().addClass('active');
				
			}
	
	});
	
	$('ul.main-menu li ul li a').each(function(){
		
			if($($(this))[0].href==String(window.location)) {
				
				$(this).parent().addClass('active');
				$(this).parent().parent().show();
				
			}
	
	});

	/* ---------- Submenu  ---------- */

	$('.dropmenu').click(function(e){

		e.preventDefault();

		$(this).parent().find('ul').slideToggle();

	});

});


/* ---------- Main Menu Open/Close ---------- */
jQuery(document).ready(function($){
	
	var startFunctions = true;
	
	$('#main-menu-toggle').click(function(){
		
		if($(this).hasClass('open')){
			
			$(this).removeClass('open').addClass('close');
			
			var span = $('#content').attr('class');
			var spanNum = parseInt(span.replace( /^\D+/g, ''));
			var newSpanNum = spanNum + 2;
			var newSpan = 'span' + newSpanNum;
			
			$('#content').addClass('full');
			$('.navbar-brand').addClass('noBg');
			$('#sidebar-left').hide();
			
		} else {
			
			$(this).removeClass('close').addClass('open');
			
			var span = $('#content').attr('class');
			var spanNum = parseInt(span.replace( /^\D+/g, ''));
			var newSpanNum = spanNum - 2;
			var newSpan = 'span' + newSpanNum;
	
			$('#content').removeClass('full');
			$('.navbar-brand').removeClass('noBg');
			$('#sidebar-left').show();
			
		}				
		
	});
	
});	


jQuery(document).ready(function($){

	if($(".boxchart")) {

		if (retina()) {

			$(".boxchart").sparkline('html', {
			    type: 'bar',
			    height: '60', // Double pixel number for retina display
				barWidth: '8', // Double pixel number for retina display
				barSpacing: '2', // Double pixel number for retina display
			    barColor: '#ffffff',
			    negBarColor: '#eeeeee'}
			);

			$(".boxchart").css('zoom',0.5);

		} else {

			$(".boxchart").sparkline('html', {
			    type: 'bar',
			    height: '30',
				barWidth: '4',
				barSpacing: '1',
			    barColor: '#ffffff',
			    negBarColor: '#eeeeee'}
			);

		}		

	}
});

jQuery(document).ready(function($){

	/* ---------- ToDo List Action Buttons ---------- */
	$(".todo-actions > a").click(function(){

		if ($(this).find('i').attr('class') == 'icon-check-empty') {
			$(this).find('i').removeClass('icon-check-empty').addClass('icon-check');
			$(this).parent().parent().find('span').css({ opacity: 0.25 });
			$(this).parent().parent().find('.desc').css('text-decoration', 'line-through');

		} else {
			$(this).find('i').removeClass('icon-check').addClass('icon-check-empty');
			$(this).parent().parent().find('span').css({ opacity: 1 });
			$(this).parent().parent().find('.desc').css('text-decoration', 'none');
		}

		return false;
	});

	/* ---------- ToDo List Active Sortable List ---------- */

	$(function() {
	    $(".todo-list").sortable();
	    $(".todo-list").disableSelection();
	});

});