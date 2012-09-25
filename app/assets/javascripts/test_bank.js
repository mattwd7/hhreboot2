$(document).ready(function() {
	$(".upvote").click(function(){
		var quality = $(this).parent().text()
		var new_quality = parseInt(quality) + 1;
		new_quality = (new_quality > 0 ? "+" + new_quality : new_quality)
		$(this).parent().next().show()
		$(this).parent().html($("<img src='/upvote.png' > " + new_quality + " <img src='/downvote_neutral.png' >"))
	})
	$(".downvote").click(function(){
		var quality = $(this).parent().text()
		var new_quality = parseInt(quality) - 1;
		new_quality = (new_quality > 0 ? "+" + new_quality : new_quality)
		$(this).parent().next().next().show()
		$(this).parent().html($("<img src='/upvote_neutral.png' > " + new_quality + " <img src='/downvote.png' >"))
	})
})