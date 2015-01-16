$(document).ready( function() {

    $("#btn-login").click( function() {
	var name = $("#name").val();
	var passwd = $("#password").val();
	console.log(name);
	console.log(passwd);
	for (var i = 0; i < users.length; i++) {
	    if (name === users[i].name && passwd === users[i].passwd) {
		alert(name + " login successfully!");
		bLogIn = true;
		break;
	    }
	}
	if (!bSuc) {
	    $("#btn-login").attr("href", "#login-fail-dialog");
	    $("#name").val("");
	    $("#password").val("");
	}
    });

    $("#activity").text( "Homework" );

    $("#btn-logout").click(function() {
	bLogin = false;
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
