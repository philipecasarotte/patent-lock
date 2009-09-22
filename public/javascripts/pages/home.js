$(document).ready(function() {
	$("input.submit").click(function(){
		var query = $("form input:first").val();
		$(this).attr("action", "http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO2&Sect2=HITOFF&p=1&u=%2Fnetahtml%2FPTO%2Fsearch-bool.html&r=0&f=S&l=50&TERM1='"+query+"'&FIELD1='"+query+"'&d=PTXT");
		$(this).submit();
	});
});
