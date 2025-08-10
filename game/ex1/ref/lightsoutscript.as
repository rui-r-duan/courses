/*
An ActionScript 3 tutorial by James Hamblin, http://webspace.ship.edu/jehamb/,
of Shippensburg University.

James Hamblin is a friend of flashandmath.com.

Last modified: June 28, 2008

You will find detailed explanations of the code below on the second
page of this tutorial.
*/



function setupGame():void {
	tbDoneText.text = "";
	addGameBoard();
	drawBoxes();
}

function newGame(evt:MouseEvent):void {
	removeGameBoard();
	setupGame();
}

// add a listener for the "New Game" button
btnNewGame.addEventListener(MouseEvent.CLICK,newGame);

var boxHeight:int = 40;
var boxWidth:int = 40;
var boxXSpace:int = 10;
var boxYSpace:int = 10;

function addGameBoard():void {
	
	// create a board to display all of the square buttons on
	var gb:Sprite = new Sprite();
	gb.graphics.beginFill(0xFFFFFF);
	
	// since the entire grid is at most 6x6, make enough room
	gb.graphics.drawRect(0,0,6*boxWidth+7*boxXSpace,6*boxHeight+7*boxYSpace);
	gb.graphics.endFill();
	gb.name = "gameBoard";
	gb.x = 20;
	gb.y = 20;
	this.addChild(gb);
}

function removeGameBoard():void {
	// remove the game board and all of the squares on it		
	var gb:Sprite=this.getChildByName("gameBoard") as Sprite;
	var thisClip:Sprite;
	while(gb.numChildren>0){
		thisClip=gb.getChildAt(0);
		thisClip.graphics.clear();
		gb.removeChild(thisClip);
	}
	gb.graphics.clear();
	this.removeChild(gb);
}

var onColor = 0xFF3333;
var offColor = 0x333333;
var numberOfRows:int;
var numberOfColumns:int;
var states:Array;

function drawBoxes():void {
		
	// create the squares on the game board
	var gb:Sprite = this.getChildByName("gameBoard");
	var square:Sprite;
	
	// create 3 to 6 rows and 3 to 6 columns
	numberOfRows = Math.floor(Math.random()*4+3);
	numberOfColumns = Math.floor(Math.random()*4+3);

	// create the states array, which has the same number of
	// "rows" and "columns" as our grid of squares
	states = new Array(numberOfRows);

	for (var i:int = 0; i < numberOfRows; i++) { // i = row number
		states[i] = new Array(numberOfColumns);
		for (var j:int = 0; j < numberOfColumns; j++) { // j = column number
		
			// create a square, which is by default "off"
			square = new Sprite();
			square.graphics.lineStyle(2, 0x000000);
			square.graphics.beginFill(offColor);
			square.graphics.drawRect(0,0,boxWidth,boxHeight);
			square.graphics.endFill();
			states[i][j] = false;
			gb.addChild(square);		
						
			// position the square in the correct location			
			square.x = (j+1)*boxXSpace + j*boxWidth;
			square.y = (i+1)*boxYSpace + i*boxHeight;
			square.name = "square" + String(i) + String(j);
			
			// add a dynamically created listener for this square
			square.addEventListener(MouseEvent.CLICK,createListener(i,j));
		}
	}
	randomizeGameBoard();
}

function createListener(a:int, b:int):Function {
	
	// dynamically create a listener for the square in position (a,b)
	// that switches the box at (a,b) and the adjacent boxes, and
	// then checks to see if you are done
	
	var foo:Function = function (evt:MouseEvent):void {
		switchAt(a,b);
		if (checkDone()) { tbDoneText.text = "Good job!"; }
	}
	return foo;
}

function invertState(row:int, col:int):void {
	
	// lookup the square located at (row, col)
	var gb:Sprite = this.getChildByName("gameBoard");
	var thisClip:Sprite = gb.getChildByName(("square" + row) + col);
	
	// if the square is off, turn it on, and vice versa
	if (states[row][col]) {
		thisClip.graphics.beginFill(offColor);
		thisClip.graphics.drawRect(0,0,boxWidth,boxHeight);
		thisClip.graphics.endFill();
	} else {
		thisClip.graphics.beginFill(onColor);
		thisClip.graphics.drawRect(0,0,boxWidth,boxHeight);
		thisClip.graphics.endFill();
	}
	
	// reverse the state of the square
	states[row][col] = !states[row][col];
}

function switchAt(row:int, col:int):void {
	
	// switch the square that was clicked on
	invertState(row,col);
		
	// switch the squares adjacent to the clicked square
	if (row > 0) { invertState(row-1,col); }
	if (row < numberOfRows - 1) { invertState(row+1,col); }
	if (col > 0) { invertState(row,col-1); }
	if (col < numberOfColumns - 1) { invertState(row,col+1); }
}

function checkDone():Boolean {
	
	// check to see if all the lights are off
	var bool:Boolean = true;
	
	for (i = 0; i < numberOfRows; i++) {
		for (j = 0; j < numberOfColumns; j++) {
			bool = bool && !states[i][j];
		}
	}
	return(bool);
}

function randomizeGameBoard():void {
	
	// randomly click the game board a random number of times
	// this ensures the game is solvable
	var r:int = Math.floor(Math.random()*5+5);
	var row:int, col:int, i:int;
	
	for (i = 0; i < r; i++) {
		row = Math.floor(Math.random() * numberOfRows);
		col = Math.floor(Math.random() * numberOfColumns);
		switchAt(row,col);
	}
}

setupGame();