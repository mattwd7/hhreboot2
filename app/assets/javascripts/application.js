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
  var prev_height = $(".user_information").height() + "px"
  $("#edit_information_link").click(function(){
    var prev_width = $(".content").width();
      $(".user_information").siblings().fadeTo("slow", "0.25")
      $(".tabs").fadeTo("slow", "0.25")
      $(".tabs").css({
        "position": "absolute",
        "top": "351px",
        "left": "1060px"
      })
      $(".tabbed-menu").css({
        "position": "absolute",
        "top": "26px",
        "left": "198px",
        "width": (prev_width)
      })
      $("#display_information").fadeOut("slow", function(){
        $("#edit_information").fadeIn("slow");
      });
      $(".user_information").animate({"width": "50%", "height": "400px"}, 1000);
    });

  $(".add_major_minors").click(function(){
      $("#major_minors").show();
      $(".user_information").css("height", "")
  })

  $("#cancel_edit button").click(function(){
      $(".user_information").siblings().fadeTo("slow", "1.0");
      $(".tabs").fadeTo("slow", "1.0")
      $("#edit_information").fadeOut("slow", function(){
        $("#display_information").fadeIn("slow")
      });
      setTimeout(function(){
        $(".tabbed-menu").css({
            "position": "relative",
            "top": "",
            "left": ""
        })
        $("#major_minors").hide();
      }, 1000)
      $(".user_information").animate({"width": "20%", "height": prev_height}, 1000);
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

// DEVISE FUNCTIONS

  $("#user_email").focus();

// HOMEPAGE FUNCTIONS


});