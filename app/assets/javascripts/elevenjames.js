$(function() { 
	center_button_row();
	
	$( ".ej-tabs" ).each(function() {
		var active = 0;
		if($(this).data("active") !== undefined) {
			active = $(this).data("active");	
		}
/* 		console.log(active); */
		$(this).tabs({active: active});
	})
	$(".ej-modal").each(function() {
		var width = $(this).data("width") || 537;
/* 		console.log([$this.parents(".ui-dialog").get(0), width]); */
		$(this).dialog({
			modal:true,
			width: width,
			draggable: false,
			resizable: false,
			dialogClass: "ej-modal",
			autoOpen: true,
			open: function() {
				var $this = $(this);
				$this.find(".button-close").click(function(e) {
					$this.dialog("close");
				});
				$(".ui-widget-overlay").click(function(e) {
					$this.dialog("close");
				});
				$this.parents(".ui-dialog").addClass($this.data("class")).css("top", "60px");
				center_button_row();
			}
		});
	})
	
	$("body").delegate(".ej-notification .close", "click", function() {
		$(this).parents(".ej-notification").fadeOut(700,function() {
			$(this).remove();
		})
	})
	
	$("ul.ej-queue li .close").click(function() {
		$(this).parent().fadeOut(700,function() {
			$(this).remove();
			arrange_queue();
		})
	})
	
	function arrange_queue() {
		$("ul.ej-queue li.wrap").removeClass("wrap");
		$("ul.ej-queue li:nth-child(2n)").addClass("wrap");
	}
	
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
	
	$(".photo-slider").bjqs({
		width: 540,
		height: 675,
		automatic: false,
		showcontrols: false,
		keyboardnav: false,
		randomstart: false,
		responsive: false,
		centermarkers: false
	})
	
	$(".photo-slider .bjqs-markers.real a").click(function() {
		var index = $(this).parents("ol").find("li").index();
		$(this).parents(".bjqs-markers").next().find("li").eq(index).trigger("click");
/* 		console.log([index,$(this).parents(".bjqs-markers").next().find("li").eq(index).find("a")]) */
		return false;
	})
	
	$(".static-slider").each(function() {
		$(this).bjqs({
			width: 302,
			height: 384,
			automatic: false,
			showmarkers : false,
			keyboardnav : false,
			nexttext : '&nbsp;',
			prevtext : '&nbsp;',
			randomstart : false,
			responsive : false,
			centercontrols: false
		})
	});

	$("#signup-page .dual-radio").buttonset({
		create: function() {
			var $this  = $(this);
			$this.find("label").click(function() {
				$this.find(">div").removeClass("selected");
				$(this).parent().addClass("selected");
			})
		}
	});
	
	$("#signup-page .step2").buttonset({
		create: function() {
			var $this = $(this);
			$this.find("label").click(function() {
				$this.find(".title").removeClass("selected");
				$(this).parent().addClass("selected");
			})
		}
	})
	
	$("#signup-page .checkbox-row input").button();
	
	$(".shipping-billing-same input").prop("checked", false);
	$(".shipping-billing-same input").on("change",function() {
		$(".shipping-info").toggleClass("disable");
/* 		console.log($(".shipping-info")); */
	});
	
	$(".select-wrapper select").on("change",function() {
        update_select(this);
    })
    
    $(".select-wrapper select").each(function() {
        update_select(this);
    })
    
    function update_select(sel_instance) {
        var val = $(sel_instance).val()
        
        var text_value = $(sel_instance).find("option[value="+val+"]").text();
        $(sel_instance).parents(".select-wrapper").find(".value").text(text_value);
/*         console.log(text_value) */
    }
	
	
})

function center_button_row() {
	
	$(".button-row:not('.not-centered'), .dynamic-centered").each(function() {
		var width = 0;
		$("> *",this).each(function() {
			$this = $(this);
			width += $this.outerWidth(true);
/* 			console.log($this.outerWidth(true)); */
		})
		console.log(width);
		$(this).width(width);
		
	})
	
}