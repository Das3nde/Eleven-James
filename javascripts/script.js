$(function() { 
	$( ".ej-tabs" ).tabs();
	$(".ej-modal").dialog({
	modal:true,
	width:537,
	draggable: false,
	resizable: false,
	dialogClass: "ej-modal"
	})
	
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