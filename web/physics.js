$(document).ready(function(){
    setupControls() ;
	setTimeout(hideBanner, 10) ;
});

function hideBanner()
{
  if ($('div[id*="divadv"]').css("display") == "block")
  {
    $('div[id*="divadv"]').css({"display":"none"}) ;
  }
  else
  {
    setTimeout(hideBanner, 10) ;
  }
}

$(window).resize(function(){
	setupControls() ;
}); 

function setupControls(){
	var canvas = $('#canvas') ;
	
	$("canvas").attr('width', $('#container').width());
	$("canvas").attr('height', $('#container').height());
	
	var details = $('#details') ;
	var position = $('#position') ;
	
	var left = canvas.offset().left + 5 + "px" ;
	var top = canvas.offset().top + "px" ;
	
	details.css({
		"left": left, "top": top
	});
	
	position.css({
		"left": canvas.offset().left + canvas.width() - position.width() - 5 + "px", 
		"top": canvas.offset().top + "px"
	});
}