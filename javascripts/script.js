$(function() { 
	$( ".ej-tabs" ).tabs();
	
	var width = 0;
	$(".button-row .button").each(function() { 
		width += $(this).outerWidth(true, true);
	})
	$(".button-row").width(width);
})