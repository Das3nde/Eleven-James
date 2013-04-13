$(function() { 
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
	
	
	
	center_button_row();
})

function center_button_row() {
	
	$(".button-row").each(function() {
		var width = 0;
		$(".button",this).each(function() {
			$this = $(this);
			width += $this.outerWidth(true, true);
		})
		$(this).width(width);
	})
	
}