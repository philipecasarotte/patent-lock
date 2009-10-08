$(document).ready(function() {
	$(".more_info").toggle(function(){
       $(this).next(".info_text:hidden").slideDown("slow");
     },
     function () {
       $(this).next(".info_text:visible").slideUp("fast");
	   }
	);
	
	//Save and Exit
	$("#exit_button").click(function(){
		$("#order_save_and_exit").val("yes");
		$("form").submit();
	});
});