$(document).ready(function() {

	var i = 0;
	var steep_callback;
	
	$(".bt_add a").click(function(e) {
		if ($(this).attr("onclick") != "") {
			steep_callback = $(this).attr("onclick");
			$(this).attr("onclick", "");
		}
		steep_callback();

		$("#inventors_first_name, #inventors_last_name, #inventors_street_address, #inventors_state, #inventors_email, #inventors_middle_name, #inventors_citizenship, #inventors_city, #inventors_zipcode").each(function(index) {
			$(this).attr("id", $(this).attr("id") + "_" + i).attr("name", $(this).attr("name") + "[]").prev("label").attr("for", $(this).attr("for") + "_" + i);
		});
		i++;
	});

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