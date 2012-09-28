$(document).ready(function() {
  var leftWidth = $(".left").width();
  var rightWidth = $(".right").width();
  var totalWidth = leftWidth + rightWidth + 30;
  $("#navigation").css("width", (totalWidth) + 'px');

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
        }, 10000)
  });

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
    $("#dining_menu").siblings().fadeTo("slow", "1.0")
    $("#dining_menu").fadeTo("slow", "0", function(){
      $(this).hide()
    })
  })  

  /*$("#dining_menu").click(function(){
    $("#dining_menu").siblings().fadeTo("slow", "1.0")
    $("#dining_menu").fadeTo("slow", "0", function(){
      $(this).hide()
    })
  })*/

})