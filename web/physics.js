$(document).ready(function(){
	setupControls() ;
});

$(window).resize(function(){
	setupControls() ;
}); 

function setupControls(){
	var container = $('#container') ;
	var canvas = $('#canvas') ;
	
	//canvas.css({"width": container.width(), "height":"600px"});
	
	var fps = $('#fps') ;
	var position = $('#position') ;
	
	var left = canvas.offset().left + canvas.width() - fps.width() - 5 + "px" ;
	var top = canvas.offset().top + "px" ;
	
	fps.css({"left": left, "top": top});

	position.css({
		"left": canvas.offset().left + 5 + "px", 
		"top": canvas.offset().top + "px"
	});
}