$(document).ready(function() {

	setTimeout(function(){
		$("#posts .user").each(function(){
			if ($(this).height() > $(this).next().height()){
				$(this).next().css("height", $(this).height() + "px")
			}
		})
	}, 500)
})