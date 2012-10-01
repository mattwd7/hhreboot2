$(document).ready(function() {
  var leftWidth = $(".left").width();
  var rightWidth = $(".right").width();
  var totalWidth = leftWidth + rightWidth + 30;
  //$("#navigation").css("width", (totalWidth) + 'px');

  $("#navigation a").hover(function(){
    $(this).animate({
      color: "white"
    }, 300)
  }, function(){
    $(this).animate({
      color: "black"
    }, 300)
  })

  //Display dining menu
  $("#dining_menu_link").click(function(){
    $("#dining_menu").siblings().fadeTo("slow", "0.25")
    $("#dining_menu").fadeTo("slow", "1.0")
  })

  $("#close").click(function(){
    $("#dining_menu").siblings().fadeTo("slow", "0.8")
    $("#dining_menu").fadeTo("slow", "0", function(){
      $(this).hide()
    })
  })  

  $("#resources_link").click(function(){
    $("#resources_panel").show("blind");
  })

  $(".close_resources").mouseleave(function(){
    if($("#resources_panel").css("display") != "none"){
      //if(!$("#resources_panel").mouseover() && !$("#navigation").mouseover()){
         $("#resources_panel").hide("blind");
      //}
    }
  })

  /*$("#dining_menu").click(function(){
    $("#dining_menu").siblings().fadeTo("slow", "1.0")
    $("#dining_menu").fadeTo("slow", "0", function(){
      $(this).hide()
    })
  })*/

})