$(document).ready(function() {
  var leftWidth = $(".left").width();
  var rightWidth = $(".right").width();
  var totalWidth = leftWidth + rightWidth + 30;
  //$("#navigation").css("width", (totalWidth) + 'px');

  $("#navigation a").hover(function(){
    $(this).animate({
      color: "white"
    }, 250)
  }, function(){
    $(this).animate({
      color: "black"
    }, 250)
  })

  $("#about_link").click(function(){
    $("#about").click();
  })

  //Display dining menu
  $("#dining_menu_link").click(function(){
    $("#dining_menu").siblings().fadeTo("slow", "0.25")
    $("#dining_menu").fadeTo("slow", "1.0")
  })

  $("#pseudo_dining_menu_link").click(function(){
    $("#dining_menu_link").click();
  })

  $("#close").click(function(){
    $("#dining_menu").siblings().not(".left1, .left2, .right, #background_image").fadeTo("slow", "1")
    $(".left1, .left2, .right, #background_image").fadeTo("slow", "0.8")
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

  $(function() {
    $( "#accordion" ).accordion({
      collapsible: false
    });
  });

  function cycleSections(){
    var next = $(".cyclotron").nextAll("h3");
    $(".cyclotron").removeClass("cyclotron");
    if (next.length ==0){
      next = $("#top")
    }
    next.addClass("cyclotron");
    next.click();
    if ($(document).mousemove()){
      return false;
    }
    else{
      setTimeout(cycleSections, 3000)
    }

  };

  var timer;
  $(document).mousemove(function() {
      if (timer) {
          clearTimeout(timer);
          timer = 0;
      }

      timer = setTimeout(function(){
          cycleSections();
        }, 15000)
  });

  /*$("#dining_menu").click(function(){
    $("#dining_menu").siblings().fadeTo("slow", "1.0")
    $("#dining_menu").fadeTo("slow", "0", function(){
      $(this).hide()
    })
  })*/

})