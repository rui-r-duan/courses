var canvas ;
var context ;

// mask
var canvas_bak;
var context_bak;

var canvasWidth = 500;
var canvasHeight = 400;

var canvasTop;
var canvasLeft;

// pencil stroke size
var size = 1;
var color  = '#000000';

var draw_graph = function(graphType,obj){

    $("#canvas_bak").css("z-index",1);

    chooseImg(obj);
    var canDraw = false;

    var startX;
    var startY;

    var mousedown = function(e){
	context.strokeStyle= color;
	context_bak.strokeStyle= color;
	context_bak.lineWidth = size;
	e=e||window.event;
	startX = e.clientX - canvasLeft;
	startY = e.clientY - canvasTop;
	context_bak.moveTo(startX ,startY );
	canDraw = true;

	if(graphType == 'pencil'){
	    context_bak.beginPath();
	}else if(graphType == 'circle'){
	    context.beginPath();
	}else if(graphType == 'rubber'){
	    context.clearRect(startX - size * 10 ,  startY - size * 10 , size * 20 , size * 20);
	}
    };

    var mouseup = function(e){
	e=e||window.event;
	canDraw = false;
	var image = new Image();
	if(graphType!='rubber'){
	    image.src = canvas_bak.toDataURL();
	    image.onload = function(){
		context.drawImage(image , 0 ,0 , image.width , image.height , 0 ,0 , canvasWidth , canvasHeight);
		clearContext();
		saveImageToAry();
	    };
	}
    };


    function chooseImg(obj){
	var imgAry  = $("#drawController img");
	for(var i=0;i<imgAry.length;i++){
	    $(imgAry[i]).removeClass('border_choose');
	    $(imgAry[i]).addClass('border_nochoose');
	}
	$(obj).removeClass("border_nochoose");
	$(obj).addClass("border_choose");
    }

    var  mousemove = function(e){
	e=e||window.event;
	var x = e.clientX   - canvasLeft;
	var y = e.clientY  - canvasTop;

	if(graphType == 'square'){
	    if(canDraw){
		context_bak.beginPath();
		clearContext();
		context_bak.moveTo(startX , startY);
		context_bak.lineTo(x  ,startY );
		context_bak.lineTo(x  ,y );
		context_bak.lineTo(startX  ,y );
		context_bak.lineTo(startX  ,startY );
		context_bak.stroke();
	    }

	}else if(graphType =='line'){
	    if(canDraw){
		context_bak.beginPath();
		clearContext();
		context_bak.moveTo(startX , startY);
		context_bak.lineTo(x  ,y );
		context_bak.stroke();
	    }

	}else if(graphType == 'pencil'){
	    if(canDraw){
		context_bak.lineTo(e.clientX   - canvasLeft ,e.clientY  - canvasTop);
		context_bak.stroke();
	    }

	}else if(graphType == 'circle'){
	    clearContext();
	    if(canDraw){
		context_bak.beginPath();
		var radii = Math.sqrt((startX - x) *  (startX - x)  + (startY - y) * (startY - y));
		context_bak.arc(startX,startY,radii,0,Math.PI * 2,false);
		context_bak.stroke();
	    } else {
		context_bak.beginPath();
		context_bak.arc(x,y,20,0,Math.PI * 2,false);
		context_bak.stroke();
	    }

	}else if(graphType == 'handwriting'){
	    if (canDraw) {
		context_bak.beginPath();
		context_bak.strokeStyle = color;
		context_bak.fillStyle  = color;
		context_bak.arc(x,y,size*10,0,Math.PI * 2,false);
		context_bak.fill();
		context_bak.stroke();
		context_bak.restore();
	    } else {
		clearContext();
		context_bak.beginPath();
		context_bak.fillStyle  = color;
		context_bak.arc(x,y,size*10,0,Math.PI * 2,false);
		context_bak.fill();
		context_bak.stroke();
	    }

	} else if(graphType == 'rubber') {
	    context_bak.lineWidth = 1;
	    clearContext();
	    context_bak.beginPath();
	    context_bak.strokeStyle =  '#000000';
	    context_bak.moveTo(x - size * 10 ,  y - size * 10 );
	    context_bak.lineTo(x + size * 10  , y - size * 10 );
	    context_bak.lineTo(x + size * 10  , y + size * 10 );
	    context_bak.lineTo(x - size * 10  , y + size * 10 );
	    context_bak.lineTo(x - size * 10  , y - size * 10 );
	    context_bak.stroke();
	    if (canDraw) {
		context.clearRect(x - size * 10 ,  y - size * 10 , size * 20 , size * 20);
	    }
	}
    };

    var mouseout = function(){
	if(graphType != 'handwriting'){
	    clearContext();
	}
    };

    $(canvas_bak).unbind();
    $(canvas_bak).bind('mousedown',mousedown);
    $(canvas_bak).bind('mousemove',mousemove);
    $(canvas_bak).bind('mouseup',mouseup);
    $(canvas_bak).bind('mouseout',mouseout);
};

var clearContext = function(type){
    if(!type){
	context_bak.clearRect(0,0,canvasWidth,canvasHeight);
    }else{
	context.clearRect(0,0,canvasWidth,canvasHeight);
	context_bak.clearRect(0,0,canvasWidth,canvasHeight);
    }
};
