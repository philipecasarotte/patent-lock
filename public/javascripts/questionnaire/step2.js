$(document).ready(function() {

	// var i = 0;
	// 	var steep_callback;
	// 	
	// 	$(".bt_add a").click(function(e) {
	// 		e.preventDefault();
	// 		if ($(this).attr("onclick") != "") {
	// 			steep_callback = $(this).attr("onclick");
	// 			$(this).attr("onclick", "");
	// 		}
	// 		steep_callback();
	// 
	// 		$("#inventors_first_name, #inventors_last_name, #inventors_street_address, #inventors_state, #inventors_email, #inventors_middle_name, #inventors_citizenship, #inventors_city, #inventors_zipcode").each(function(index) {
	// 			$(this).attr("id", $(this).attr("id") + "_" + i).attr("name", $(this).attr("name") + "[]").prev("label").attr("for", $(this).attr("for") + "_" + i);
	// 		});
	// 		i++;
	// 	});

	//Yes
	$("#answer3_body_yes").click(function(){
		if (inventors_count > 0){
			$(".bt_add").hide();
			$("#inventors").hide();
			$("#inventors input, #inventors select").attr("disable", "disable");
			$("#more_inventor").attr("checked", false);
		};
	});
	
	//No
	$("#answer3_body_no").click(function(){
		$(".bt_add").show();
		$("#inventors").show();
		$("#inventors input, #inventors select").attr("disable", "");
		$("#more_inventor").attr("checked", true);
	});
	
	if (sole == "Yes"){
		$(".bt_add").hide();
		$("#inventors").hide();
		$("#more_inventor").attr("checked", false);
	}else{
		$(".bt_add").show();
		$("#more_inventor").attr("checked", false);
	};
});