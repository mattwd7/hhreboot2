$(document).ready(function() {

	setTimeout(function(){
		$("#posts .user").each(function(){
			if ($(this).height() > $(this).next().height()){
				$(this).next().css("height", $(this).height() + "px")
			}
		})
	}, 500)

	$("#markdown_link").click(function(){
		$("#markdown_cheatsheet").toggle("fold");
	})
})