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
		current_user = i;
		console.log("user_index: " + i);

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

    $("#btn-save").click(function() {
	activities.push({activity: $("#activity").text(),
			 start_time: $("#start-time").val(),
			 end_time: $("#end-time").val(),
			 notes: $("#note").val()});
	var txt = '<li><a href="#">'
		+ activities[activities.length - 1].activity + '</a></li>';
	var activity_list = $("ol");
	activity_list.append(txt);

	// clear this page
	$("#note").val("");

	activity_list.listview("refresh");
	$(":mobile-pagecontainer").pagecontainer("change", "#act-list-page");
	console.log(activities[activities.length-1]);
    });

    $("#activity").text( "Homework" );

    $("#btn-logout").click(function() {
	bLogIn = false;
	$("#name").val("");
	$("#password").val("");
    });

    $("#myPopup li").click(function() {
	$("#activity").text($(this).text());
	$("#myPopup").popup("close");
    });

    appendActivity();
});

var users = [
    {name: "ryan", passwd: "123"},
    {name: "zhenzhen", passwd: "456"}
];

var bLogIn = false;
var current_user = -1;

var activities = [
    {
	activity: "Drawing",
	start_time: "7:35 am",
	end_time: "8:45 am",
	notes: "read the book first"},
    {
	activity: "Homework",
	start_time: "9:00 am",
	end_time: "10:00 am",
	notes: "Do whatever you want."}
];

function appendActivity() {
    var txt;
    for (var i = 0; i < activities.length; i++) {
	txt = "<li><a href=#>" + activities[i].activity + "</a></li>";
	$("ol").append(txt);
    }
}
