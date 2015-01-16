$(document).ready( function() {

    $("#btn-login").click( function() {
	var name = $("#name").val();
	var passwd = $("#password").val();
	console.log(name);
	console.log(passwd);
	for (var i = 0; i < users.length; i++) {
	    if (name === users[i].name && passwd === users[i].passwd) {
		console.log(name + " login successfully!");
		bLogIn = true;
		$(this).attr("href", "#act-list-page");
		$(this).attr("data-transition", "slide");
		break;
	    }
	}
	if (!bLogIn) {
	    $(this).attr("href", "#login-fail-dialog");
	    $(this).attr("data-transition", "fade");
	    $("#name").val("");
	    $("#password").val("");
	}
    });

    $("#activity").text( "Homework" );

    $("#btn-logout").click(function() {
	bLogIn = false;
	$("#name").val("");
	$("#password").val("");
    });
});

var users = [
    {name: "ryan", passwd: "123"},
    {name: "zhenzhen", passwd: "456"}
];

var bLogIn = false;

var activities = [];
