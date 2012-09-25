$(document).ready(function() {
	$("#downvote img").click(function(){
		$(this).attr("src", "/downvote.png");
		var quality = $(this).parent().parent().text();
		var new_quality = parseInt(quality) - 1;
		new_quality = (new_quality > 0 ? "+" + new_quality : new_quality)
		$(this).parent().parent().next().next().show()
		$(this).parent().parent().html($("<div><img src='/upvote_neutral.png' /> " + new_quality + " <img src='/downvote.png' /></div>"))
	})
	$("#upvote img").click(function(){
		$(this).attr("src", "/upvote.png");
		var quality = $(this).parent().parent().text();
		var new_quality = parseInt(quality) + 1;
		new_quality = (new_quality > 0 ? "+" + new_quality : new_quality)
		$(this).parent().parent().next().show()
		$(this).parent().parent().html($("<div><img src='/upvote.png' /> " + new_quality + " <img src='/downvote_neutral.png' /></div>"))
	})
})