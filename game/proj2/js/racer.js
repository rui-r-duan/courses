/*global Car, TO_RADIANS, drawRotatedImage */

var canvas   = document.getElementById('myCanvas');
var context  = canvas.getContext('2d');
var ctxW     = canvas.width;
var ctxH     = canvas.height;
var player   = new Car();
var track    = new Image();
var trackHit = new Image();
var goalImg  = new Image();
var elPX     = document.getElementById('px');
var elPY     = document.getElementById('py');
var timer;
var seconds = 59;
var milliseconds = 59;
var timer_sec = document.getElementById('seconds');
var timer_ms = document.getElementById('ms');

// gameState and gameLevel control the whole game states
var gameState = 0;		// 1: "run", 2: "lose", 3: "win"
var maps = [
    "images/level_one.png",
    "images/level_two.png"
];
var gameLevel = 0;		// 0 and 1
var gameloopid;

track.src = maps[gameLevel];
trackHit.src = maps[gameLevel];
goalImg.src = "images/goal.png";
var hit = new HitMap(trackHit);
var goal = new Goal(goalImg);

// Keyboard Variables
var key = {
    UP: 38,
    DOWN: 40,
    LEFT: 37,
    RIGHT: 39
};

var keys = {
    38: false,
    40: false,
    37: false,
    39: false
};


function speedXY (rotation, speed) {
    return {
        x: Math.sin(rotation * TO_RADIANS) * speed,
        y: Math.cos(rotation * TO_RADIANS) * speed * -1
    };
}

function step(car) {
    if (gameState == 0) {	// init

	if (gameLevel == 0) {
	    goal.x = 546;
	    goal.y = 488;
	} else if (gameLevel == 1) {
	    goal.x = 530;
	    goal.y = 430;
	    track.src = maps[gameLevel];
	    trackHit.src = maps[gameLevel];
	    hit = new HitMap(trackHit);
	    car = new Car();
	    startTimer();
	} else {		// gameLevel > 1
	    context.fillText("YOU WIN!!", 180, 180);
	    cancelTimer();
	    window.cancelAnimationFrame(gameloopid);
	    return;
	}

	// press any arrow key to start the level
	if (keys[key.UP] || keys[key.DOWN] || keys[key.LEFT]
	    || keys[key.RIGHT]) {

	    console.log("Game started");
	    gameState = 1;	// run
	    startTimer();
	}
	return;
    }

    if (car.code === 'player'){

        // constantly decrease speed
        if (!car.isMoving()){
            car.speed = 0;
        } else {
            car.speed *= car.speedDecay;
        }

        // keys movements
        if (keys[key.UP])  { car.accelerate(); }
        if (keys[key.DOWN]){ car.decelerate(); }
        if (keys[key.LEFT]){ car.steerLeft(); }
        if (keys[key.RIGHT]){ car.steerRight(); }

        var speedAxis = speedXY(car.rotation, car.speed);
        car.x += speedAxis.x;
        car.y += speedAxis.y;

        // collisions
        if (car.collisions.left.isHit(hit)){
            car.steerRight();
            car.decelerate(1);
        }
        if (car.collisions.right.isHit(hit)){
            car.steerLeft();
            car.decelerate(1);
        }
        if (car.collisions.top.isHit(hit)){
            car.decelerate(1);
        }
        if (car.collisions.bottom.isHit(hit)){
            car.decelerate(1);
        }

	// If car hit the goal from left to right, it wins this level.
	if (goal.isPointInGoal(car.collisions.top.getXY())
	    && ! car.collisions.bottom.getXY().x < goal.x) {

	    gameState = 0;	// init
	    console.log("You win!");
	    gameLevel++;
	    cancelTimer();
	}

        // info
        elPX.innerHTML = Math.floor(car.x);
        elPY.innerHTML = Math.floor(car.y);
    }
}
function draw(car) {
    context.clearRect(0,0,ctxW,ctxH);
    context.drawImage(track, 0, 0);
    context.drawImage(goal.img, goal.x, goal.y);
    drawRotatedImage(car.img, car.x, car.y, car.rotation);
    drawCollisionPoints(car);
}

function drawCollisionPoints(car) {
    context.beginPath();
    context.fillStyle = "red";
    var p = car.collisions.top.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();

    context.beginPath();
    p = car.collisions.left.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();

    context.beginPath();
    p = car.collisions.bottom.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();

    context.beginPath();
    p = car.collisions.right.getXY();
    context.arc(p.x, p.y, 2, 0, 360 * TO_RADIANS);
    context.fill();
    context.closePath();
}

// Keyboard event listeners
$(window).keydown(function(e){
    if (keys[e.keyCode] !== 'undefined'){
        keys[e.keyCode] = true;
        // e.preventDefault();
    }
});
$(window).keyup(function(e){
    if (keys[e.keyCode] !== 'undefined'){
        keys[e.keyCode] = false;
        // e.preventDefault();
    }
});

function frame() {
    step(player);
    draw(player);
    gameloopid = window.requestAnimationFrame(frame);
}

function startTimer() {
    seconds = 59;
    milliseconds = 99;
    timer = setInterval(updateTimer, 1);
}

function cancelTimer() {
    clearInterval(timer);
    timer_sec.innerHTML = seconds;
    timer_ms.innerHTML = milliseconds;
}

function updateTimer() {
    timer_sec.innerHTML = seconds;
    timer_ms.innerHTML = milliseconds;

    milliseconds--;
    if (milliseconds == 0) {
	milliseconds = 59;
	seconds--;
    }

    if (seconds == 0) {
	cancelTimer();

	// stop this level, stop keyboard control
	console.log("You lose");
	gameState = 2;
	context.fillText("You Lose", 250, 250);
	window.cancelAnimationFrame(gameloopid);
    }
}

frame();
