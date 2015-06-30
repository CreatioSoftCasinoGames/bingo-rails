// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {

	$("#btnAdd").click(function (e) {
		$("#bot_probabilities").append($("#templates .bots_probability_row").clone());
		return(false)
	});

	$(document).on("click", ".delete-bots-probabilities", function() {
		if(confirm("Are you sure?")) {
			var parent_row = $(this).closest(".bots_probability_row");
			var ai_id = $("#bot_probabilities").data("ai_id");
			var min = $(this).closest(".bots_probability_row").data("min")
			var max = $(this).closest(".bots_probability_row").data("max")
			var rowValue = $(this).closest("#bot_probabilities").data("ai_id")
      $.ajax({
        url: "/ais/" + rowValue + "/bot_probabilities.json",
        method: "delete",
        data: {min_players: min, max_players: max},
        success: function(data, status) {
          parent_row.replaceWith("")
        }
      });
		}	
		return false
	});	

	$(document).on("change", ".box_width.min_players", function() {
		$(this).closest(".bots_probability_row").find(".min_players").val($(this).val())
	})

	$(document).on("change", ".box_width.max_players", function() {
		$(this).closest(".bots_probability_row").find(".max_players").val($(this).val())
	})

	


})

$(function() {
	$('.set-time').click(function (e){
		var timeRemainig = $('.time-remaining').val();
		$.ajax({
			url: "/dynamic_iaps/special_deal_end_time",
			method: "put",
			data: {end_time: timeRemainig},
			success: function(data, status){
				if (data.success) {
					window.location = data.redirect_to
					alert(data.message);
				} else{
					window.location = data.redirect_to
					alert(data.message);
				}
			}
		});
	});
	return false;
});








