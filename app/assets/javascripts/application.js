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

$(document).ready(function () {
	$("#btnAdd").click(function (e) {
		$("#bot_probabilities").append($("#templates .bots_probability_row").clone());
		return(false)
	});

	$(document).on("change", ".box_width.min_players", function() {
		$(this).closest(".bots_probability_row").find(".min_players").val($(this).val())
	})

	$(document).on("change", ".box_width.max_players", function() {
		$(this).closest(".bots_probability_row").find(".max_players").val($(this).val())
	})

})








