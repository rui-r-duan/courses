// Select all spans
jQuery('span');
// or use the $(dollar) sign to make it shorter
$('span');

// Add class blue to all spans within content id
$('#content span').addClass('blue');

// Add click-handler for current and future anchors
$('a').on('click', function(event) {
    console.log('got event', event);
    event.preventDefault();
    event.stopPropogation();
});


// Slowly enlarge h1 on mouse enter and restore on mouse leave
$('h1').on('mouseenter mouseleave', function(event) {
    var fs = parseInt($(this).css("font-size"), 10);
    if (fs > 30) {
	$(this).animate({fontsize: "30px"}, "slow");
    } else {
	$(this).animate({fontsize: "50px"}, "slow");
    }
});

// Remove all handlers
$('h1').off();
