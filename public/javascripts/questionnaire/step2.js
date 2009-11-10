$(document).ready(function() {
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
	}else{
		$(".bt_add a").click();
	};
});