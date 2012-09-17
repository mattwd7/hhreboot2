// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui-1.8.23.custom.min
//= require_tree .

$(document).ready(function() {
// CLASS MANAGEMENT FUNCITONS
  // Field -> courses selection lists
  $("#selections").hide();
  $(".hidden_element").hide();

	$("#show_fields").click(function(){
		$("#selections").toggle("clip");
	})

  $('#field_select').change(function() {
    $.ajax({
      url: "#{/manage_classes}",
      data: {
        field : $('#field_select').val()
      },
      dataType: "script"
    });
  });

// USER PROFILE FUNCTIONS
  // Tabbed profile
  $(".tabs li").click(function(){
    if (!$(this).hasClass("selected")) {
      $(".tabs li").removeClass("selected");
      $(this).addClass("selected");
      var selectionId = $(this).attr("id");
      $(".page").hide(); // .hide() is the same as .css("display","none");
      $(".page#" + selectionId).show();
    }
  });

  //Edit Profile animation
  $("#edit_information_link").click(function(){
    var prev_width = $(".content").width();
      $(".user_information").siblings().fadeTo("slow", "0.25")
      $(".tabbed-menu").css({
        "position": "absolute",
        "top": "107px",
        "left": "293px",
        "width": (prev_width)
      })
      $("#display_information").fadeOut("slow", function(){
        $("#edit_information").fadeIn("slow");
      });
      $(".user_information").animate({width: "50%"}, 1000);
    });

  $(".add_major_minors").click(function(){
      $("#major_minors").show();
  })

  $("#cancel_edit button").click(function(){
      $(".user_information").siblings().fadeTo("slow", "1.0");
      $("#edit_information").fadeOut("slow", function(){
        $("#display_information").fadeIn("slow")
      });
      setTimeout(function(){
        $(".tabbed-menu").css({
            "position": "relative",
            "top": "",
            "left": ""
        })
      }, 1000)
      $(".user_information").animate({width: "20%"}, 1000);
  })

// MESSAGING FUNCTIONS

  $(".my_messages_tabs li").click(function(){
    if (!$(this).hasClass("selected")) {
      $(".my_messages_tabs li").removeClass("selected");
      $(this).addClass("selected");
      var selectionId = $(this).attr("id");
      $(".page").hide(); // .hide() is the same as .css("display","none");
      $(".page#" + selectionId).show();
    }
  });

//DEVISE FUNCTIONS

  $("#user_email").focus();

//HOMEPAGE FUNCTIONS
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

});