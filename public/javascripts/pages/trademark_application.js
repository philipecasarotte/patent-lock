$(document).ready(function() {

	//Yes
	$("#trademarks_being_used_yes").click(function(){
		$("#trademarks_first_date").attr("disabled", "");
	});
	
	//No
	$("#trademarks_being_used_no").click(function(){
		$("#trademarks_first_date").attr("disabled", "disabled");
	});
});