$(document).ready(function() {
	$("input.submit").click(function(){
		var query = $("form input:first").val();
		window.open("http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=%2Fnetahtml%2FPTO%2Fsearch-bool.html&r=0&f=S&l=50&TERM1="+query+"&FIELD1=&co1=AND&TERM2=&FIELD2=&d=PTXT");
		return false;
	});
	
	$("#get_started_home").flashembed({
		src:"/flashes/banner.swf",
		width: "200px",
		height: "281px",
		allowscriptaccess: "always",
		allowFullScreen: "true"
	});
});
