$(document).ready(function() {
	$("#more_info").toggle(function(){
       $("#info_text:hidden").slideDown("slow");
     },
     function () {
       $("#info_text:visible").slideUp("fast");
	   }
	);
	
	//Save and Exit
	$("#exit_button").click(function(){
		$("#answer_save_and_exit").val("yes");
		$("form").submit();
	});
});