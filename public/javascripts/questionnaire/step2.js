$(document).ready(function() {	
	
	$(".bt_add a").click();
	
	//Yes
	$("#answer3_body_yes").click(function(){
		$(".bt_add").hide();
	});
	
	//No
	$("#answer3_body_no").click(function(){
		$(".bt_add").show();
	});
	
	if (sole == "Yes"){
		$(".bt_add").hide();
	};
});