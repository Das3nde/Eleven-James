$(function() { 
	center_button_row();
	
	$( ".ej-tabs" ).tabs();
	$(".ej-modal").dialog({
		modal:true,
		width:537,
		draggable: false,
		resizable: false,
		dialogClass: "ej-modal",
		autoOpen: true,
		open: function(e,ui) {
			$(this, ".button-close").click(function() {
				$(e.target).dialog("close");
			});
			$(".ui-widget-overlay").click(function() {
				$(e.target).dialog("close");
			});
		}
	});
	
	$('#homepage-slider').bjqs({
		width: 1084,
		height: 531,
		animduration : 1450,
		animspeed : 6000,
		showmarkers : false,
		keyboardnav : false,
		nexttext : '&nbsp;',
		prevtext : '&nbsp;',
		randomstart : false,
		responsive : false,
		automatic: true
	});
	
	
	
})

function center_button_row() {
	
	$(".button-row, .dynamic-centered").each(function() {
		var width = 0;
		$("> *",this).each(function() {
			$this = $(this);
			width += $this.outerWidth(true);
			console.log($this.outerWidth(true));
		})
		console.log(width);
		$(this).width(width);
		
	})
	
}