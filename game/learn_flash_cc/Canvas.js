(function (lib, img, cjs) {

var p; // shortcut to reference prototypes

// library properties:
lib.properties = {
	width: 640,
	height: 360,
	fps: 30,
	color: "#000000",
	manifest: [
		{src:"images/sky_background.jpg", id:"sky_background"}
	]
};



// symbols:



(lib.sky_background = function() {
	this.initialize(img.sky_background);
}).prototype = p = new cjs.Bitmap();
p.nominalBounds = new cjs.Rectangle(0,0,640,360);


(lib.Leg_Right = function() {
	this.initialize();

	// Layer 1
	this.shape = new cjs.Shape();
	this.shape.graphics.f().s("#000000").ss(10,1,1).p("Ah2jqQgOANgNARQgDAEgCAEQhABYAAB7QAAB8BABYQA+BYBYAAQBYAABAhYQA/hYAAh8QAAgsgJgoAh7ktQgIADgHAEAiek6QgVAMgTAS");
	this.shape.setTransform(21.5,31.5);

	this.shape_1 = new cjs.Shape();
	this.shape_1.graphics.f("#993333").s().p("AgGADIANgFIgBAFg");
	this.shape_1.setTransform(8.3,1.7);

	this.shape_2 = new cjs.Shape();
	this.shape_2.graphics.f("#7F3333").s().p("AiWDiQhAhXAAh8QAAh7BAhYIAGgIQANgQANgNIAzAAIgBAJIAAAKIAQAKQAeATAnADQARABATgBIAQAKIgSAdIAAA8IArAeIBWAJQAAgEABgCIAZgTQAJAoAAAsQgBB8g+BXQhABZhYAAQhYAAg+hZgAjGkcQAUgSAUgMIAOAAQgCAPgBAPg");
	this.shape_2.setTransform(21.5,31.5);

	this.addChild(this.shape_2,this.shape_1,this.shape);
}).prototype = p = new cjs.Container();
p.nominalBounds = new cjs.Rectangle(-5,-5,53,73);


(lib.Leg_Left = function() {
	this.initialize();

	// Layer 1
	this.shape = new cjs.Shape();
	this.shape.graphics.f().s("#000000").ss(10,1,1).p("ABLkkQA0ATArAwQADADADAEQBKBYAAB9QAAB6hKBYQhJBYhnAAQhmAAhKhYQhJhYAAh6QAAguAKgo");
	this.shape.setTransform(25,29.4);

	this.shape_1 = new cjs.Shape();
	this.shape_1.graphics.f("#993333").s().p("AiwDNQhIhXgBh7QAAgtAKgoIAcASQACACAAAFIBlgKIAxgeIAAg8IgUgdIATgKQAWABAUgBQAsgCAlgTIARgKIAAgKQgBgYgFgXQA1ATArAwIAGAIQBJBXABB9QgBB7hJBXQhJBYhnAAQhmAAhKhYg");
	this.shape_1.setTransform(25,29.4);

	this.addChild(this.shape_1,this.shape);
}).prototype = p = new cjs.Container();
p.nominalBounds = new cjs.Rectangle(-5,-5,60,68.7);


(lib.Character = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Left Leg
	this.instance = new lib.Leg_Left("synched",0);
	this.instance.setTransform(88,131,0.999,0.999,14.8,0,0,8,7.8);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1).to({regX:25,regY:29.4,scaleX:1,scaleY:1,rotation:10.6,x:101,y:155.2},0).wait(1).to({rotation:6.3,x:103.1,y:154},0).wait(1).to({rotation:2.1,x:105.1,y:152.8},0).wait(1).to({rotation:-2.2,x:107,y:151.4},0).wait(1).to({rotation:-6.5,x:108.7,y:149.8},0).wait(1).to({rotation:-10.8,x:110.4,y:148.2},0).wait(1).to({rotation:-15,x:112,y:146.4},0).wait(1).to({rotation:-10.8,x:110.6,y:148.2},0).wait(1).to({rotation:-6.5,x:109,y:149.8},0).wait(1).to({rotation:-2.2,x:107.4,y:151.4},0).wait(1).to({rotation:2.1,x:105.7,y:152.8},0).wait(1).to({rotation:6.3,x:103.8,y:154},0).wait(1).to({rotation:10.6,x:101.9,y:155.2},0).wait(1).to({rotation:14.9,x:99.9,y:156.2},0).wait(1));

	// Hair
	this.shape = new cjs.Shape();
	this.shape.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQEog1Bnj2");
	this.shape.setTransform(110,5);

	this.shape_1 = new cjs.Shape();
	this.shape_1.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQENhWCCjV");
	this.shape_1.setTransform(110,5);

	this.shape_2 = new cjs.Shape();
	this.shape_2.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQDxh4Ceiz");
	this.shape_2.setTransform(110,5);

	this.shape_3 = new cjs.Shape();
	this.shape_3.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQDViXC6iU");
	this.shape_3.setTransform(110,5);

	this.shape_4 = new cjs.Shape();
	this.shape_4.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQC7i4DUhz");
	this.shape_4.setTransform(110,5);

	this.shape_5 = new cjs.Shape();
	this.shape_5.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQCfjaDwhR");
	this.shape_5.setTransform(110,5);

	this.shape_6 = new cjs.Shape();
	this.shape_6.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQCDj7EMgw");
	this.shape_6.setTransform(110,5);

	this.shape_7 = new cjs.Shape();
	this.shape_7.graphics.f().s("#000000").ss(8,1,1).p("AjHCWQBokcEngP");
	this.shape_7.setTransform(110,5);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.shape}]}).to({state:[{t:this.shape_1}]},1).to({state:[{t:this.shape_2}]},1).to({state:[{t:this.shape_3}]},1).to({state:[{t:this.shape_4}]},1).to({state:[{t:this.shape_5}]},1).to({state:[{t:this.shape_6}]},1).to({state:[{t:this.shape_7}]},1).to({state:[{t:this.shape_6}]},1).to({state:[{t:this.shape_5}]},1).to({state:[{t:this.shape_4}]},1).to({state:[{t:this.shape_3}]},1).to({state:[{t:this.shape_2}]},1).to({state:[{t:this.shape_1}]},1).to({state:[{t:this.shape}]},1).wait(1));

	// Face
	this.shape_8 = new cjs.Shape();
	this.shape_8.graphics.f().s("#000000").ss(8,1,1).p("AheAAQAAApgdAdQgdAegqAAQgpAAgegeQgdgdAAgpQAAgoAdgeQAegdApAAQAqAAAdAdQAdAeAAAogAEnAAQAAApgeAdQgdAegpAAQgqAAgdgeQgdgdAAgpQAAgoAdgeQAdgdAqAAQApAAAdAdQAeAeAAAog");
	this.shape_8.setTransform(52.5,64);

	this.shape_9 = new cjs.Shape();
	this.shape_9.graphics.f().s("#000000").ss(10,1,1).p("AjHApQCsilDjCl");
	this.shape_9.setTransform(52,100.8);

	this.shape_10 = new cjs.Shape();
	this.shape_10.graphics.f("#FFCC33").s().p("AB7BGQgcgdAAgpQAAgoAcgeQAegdAqAAQApAAAdAdQAeAegBAoQABApgeAdQgdAegpgBQgqABgegegAkIBGQgdgdAAgpQAAgoAdgeQAdgdAqAAQApAAAdAdQAdAeABAoQgBApgdAdQgdAegpgBQgqABgdgeg");
	this.shape_10.setTransform(52.5,64);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.shape_10},{t:this.shape_9},{t:this.shape_8}]}).wait(15));

	// Body
	this.shape_11 = new cjs.Shape();
	this.shape_11.graphics.f().s("#000000").ss(10,1,1).p("AK8AAQAAFLjNDqQjNDrkiAAQkhAAjNjrQjNjqAAlLQAAlKDNjrQDNjqEhAAQEiAADNDqQDNDrAAFKg");
	this.shape_11.setTransform(70,80);

	this.shape_12 = new cjs.Shape();
	this.shape_12.graphics.f("#993333").s().p("AntI1QjNjqgBlLQABlKDNjrQDMjpEhgBQEiABDNDpQDNDrAAFKQAAFLjNDqQjNDrkiAAQkhAAjMjrg");
	this.shape_12.setTransform(70,80);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.shape_12},{t:this.shape_11}]}).wait(15));

	// Right Leg
	this.instance_1 = new lib.Leg_Right("synched",0);
	this.instance_1.setTransform(50.1,130,0.999,0.999,-14.8,0,0,35.6,14);

	this.timeline.addTween(cjs.Tween.get(this.instance_1).wait(1).to({regX:21.5,regY:31.5,scaleX:1,scaleY:1,rotation:-8.6,x:38.7,y:149.4},0).wait(1).to({rotation:-2.1,x:36.6,y:148},0).wait(1).to({rotation:4.3,x:34.7,y:146.4},0).wait(1).to({rotation:10.7,x:32.9,y:144.6},0).wait(1).to({rotation:17.2,x:31.4,y:142.6},0).wait(1).to({rotation:23.6,x:30.1,y:140.4},0).wait(1).to({rotation:30,x:29.1,y:138.1},0).wait(1).to({rotation:23.6,x:30.1,y:140.4},0).wait(1).to({rotation:17.2,x:31.4,y:142.6},0).wait(1).to({rotation:10.7,x:32.9,y:144.6},0).wait(1).to({rotation:4.3,x:34.7,y:146.3},0).wait(1).to({rotation:-2.1,x:36.6,y:148},0).wait(1).to({rotation:-8.5,x:38.7,y:149.4},0).wait(1).to({rotation:-14.9,x:40.9,y:150.5},0).wait(1));

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(-5,-14,150,204.2);


// stage content:



(lib.canvas = function(mode,startPosition,loop) {
	this.initialize(mode,startPosition,loop,{});

	// Character
	this.instance = new lib.Character("synched",0);
	this.instance.setTransform(650,180,1,1,0,0,0,70,80);

	this.timeline.addTween(cjs.Tween.get(this.instance).wait(1).to({regX:68.9,regY:91.5,scaleX:1.01,scaleY:1.01,x:637,y:197.4,startPosition:1},0).wait(1).to({scaleX:1.01,scaleY:1.01,x:625,y:203.2,startPosition:2},0).wait(1).to({scaleX:1.02,scaleY:1.02,x:613,y:208.7,startPosition:3},0).wait(1).to({scaleX:1.03,scaleY:1.03,x:600.8,y:214.1,startPosition:4},0).wait(1).to({scaleX:1.03,scaleY:1.03,x:588.5,y:219.2,startPosition:5},0).wait(1).to({scaleX:1.04,scaleY:1.04,x:576.2,y:224.2,startPosition:6},0).wait(1).to({scaleX:1.05,scaleY:1.05,x:563.9,y:228.9,startPosition:7},0).wait(1).to({scaleX:1.05,scaleY:1.05,x:551.4,y:233.6,startPosition:8},0).wait(1).to({scaleX:1.06,scaleY:1.06,x:538.9,y:238,startPosition:9},0).wait(1).to({scaleX:1.07,scaleY:1.07,x:526.3,y:242.4,startPosition:10},0).wait(1).to({scaleX:1.08,scaleY:1.08,x:513.7,y:246.6,startPosition:11},0).wait(1).to({scaleX:1.08,scaleY:1.08,x:501.1,y:250.6,startPosition:12},0).wait(1).to({scaleX:1.09,scaleY:1.09,x:488.4,y:254.5,startPosition:13},0).wait(1).to({scaleX:1.1,scaleY:1.1,x:475.7,y:258.3,startPosition:14},0).wait(1).to({scaleX:1.1,scaleY:1.1,x:462.9,y:261.9,startPosition:0},0).wait(1).to({scaleX:1.11,scaleY:1.11,x:450.1,y:265.5,startPosition:1},0).wait(1).to({scaleX:1.12,scaleY:1.12,x:437.3,y:268.9,startPosition:2},0).wait(1).to({scaleX:1.12,scaleY:1.12,x:424.5,y:272.2,startPosition:3},0).wait(1).to({scaleX:1.13,scaleY:1.13,x:411.6,y:275.4,startPosition:4},0).wait(1).to({scaleX:1.14,scaleY:1.14,x:398.6,y:278.5,startPosition:5},0).wait(1).to({scaleX:1.14,scaleY:1.14,x:385.7,y:281.5,startPosition:6},0).wait(1).to({scaleX:1.15,scaleY:1.15,x:372.8,y:284.4,startPosition:7},0).wait(1).to({scaleX:1.16,scaleY:1.16,x:359.8,y:287.2,startPosition:8},0).wait(1).to({scaleX:1.16,scaleY:1.16,x:346.8,y:289.9,startPosition:9},0).wait(1).to({scaleX:1.17,scaleY:1.17,x:333.8,y:292.5,startPosition:10},0).wait(1).to({scaleX:1.18,scaleY:1.18,x:320.8,y:295.1,startPosition:11},0).wait(1).to({scaleX:1.18,scaleY:1.18,x:307.8,y:297.6,startPosition:12},0).wait(1).to({scaleX:1.19,scaleY:1.19,x:294.7,y:300,startPosition:13},0).wait(1).to({scaleX:1.2,scaleY:1.2,x:281.6,y:302.3,startPosition:14},0).wait(1).to({scaleX:1.2,scaleY:1.2,x:268.6,y:304.5,startPosition:0},0).wait(1).to({scaleX:1.21,scaleY:1.21,x:255.5,y:306.7,startPosition:1},0).wait(1).to({scaleX:1.22,scaleY:1.22,x:242.4,y:308.8,startPosition:2},0).wait(1).to({scaleX:1.22,scaleY:1.22,x:229.3,y:310.8,startPosition:3},0).wait(1).to({scaleX:1.23,scaleY:1.23,x:216.2,y:312.8,startPosition:4},0).wait(1).to({scaleX:1.24,scaleY:1.24,x:203,y:314.7,startPosition:5},0).wait(1).to({scaleX:1.25,scaleY:1.25,x:189.9,y:316.5,startPosition:6},0).wait(1).to({scaleX:1.25,scaleY:1.25,x:176.8,y:318.3,startPosition:7},0).wait(1).to({scaleX:1.26,scaleY:1.26,x:163.6,y:320,startPosition:8},0).wait(1).to({scaleX:1.26,scaleY:1.26,x:150.5,y:321.6,startPosition:9},0).wait(1).to({scaleX:1.27,scaleY:1.27,x:137.3,y:323.2,startPosition:10},0).wait(1).to({scaleX:1.28,scaleY:1.28,x:124.1,y:324.8,startPosition:11},0).wait(1).to({scaleX:1.29,scaleY:1.29,x:110.9,y:326.3,startPosition:12},0).wait(1).to({scaleX:1.29,scaleY:1.29,x:97.7,y:327.7,startPosition:13},0).wait(1).to({scaleX:1.3,scaleY:1.3,x:84.6,y:329.1,startPosition:14},0).wait(1).to({scaleX:1.31,scaleY:1.31,x:71.4,y:330.4,startPosition:0},0).wait(1).to({scaleX:1.31,scaleY:1.31,x:58.2,y:331.8,startPosition:1},0).wait(1).to({scaleX:1.32,scaleY:1.32,x:45,y:333,startPosition:2},0).wait(1).to({scaleX:1.33,scaleY:1.33,x:31.8,y:334.2,startPosition:3},0).wait(1).to({scaleX:1.33,scaleY:1.33,x:18.6,y:335.3,startPosition:4},0).wait(1));

	// Cloud copy
	this.shape = new cjs.Shape();
	this.shape.graphics.f("rgba(255,255,255,0.498)").s().de(-95,-25,190,50);
	this.shape.setTransform(117.4,120,0.876,0.799);

	this.shape_1 = new cjs.Shape();
	this.shape_1.graphics.f("rgba(255,255,255,0.494)").s().p("ApLCMQj0g6ABhSQgBhRD0g7QD1g6FWAAQFYAAD0A6QD0A7AABRQAABSj0A6Qj0A7lYAAQlWAAj1g7g");
	this.shape_1.setTransform(127.7,120);

	this.shape_2 = new cjs.Shape();
	this.shape_2.graphics.f("rgba(255,255,255,0.49)").s().p("ApLCMQjzg6AAhSQAAhRDzg7QD0g6FXAAQFYAADzA6QD0A7AABRQAABSj0A6QjzA7lYAAQlXAAj0g7g");
	this.shape_2.setTransform(137.9,120);

	this.shape_3 = new cjs.Shape();
	this.shape_3.graphics.f("rgba(255,255,255,0.486)").s().p("ApKCMQjzg6AAhSQAAhRDzg7QD0g6FWAAQFYAADyA6QD0A7AABRQAABSj0A6QjyA7lYAAQlWAAj0g7g");
	this.shape_3.setTransform(148.2,120);

	this.shape_4 = new cjs.Shape();
	this.shape_4.graphics.f("rgba(255,255,255,0.482)").s().p("ApKCMQjyg6AAhSQAAhRDyg7QD0g6FWAAQFXAADzA6QDzA7AABRQAABSjzA6QjzA7lXAAQlWAAj0g7g");
	this.shape_4.setTransform(158.4,120);

	this.shape_5 = new cjs.Shape();
	this.shape_5.graphics.f("rgba(255,255,255,0.475)").s().p("ApJCMQjzg6AAhSQAAhRDzg7QDzg6FWAAQFXAADzA6QDzA7AABRQAABSjzA6QjzA7lXAAQlWAAjzg7g");
	this.shape_5.setTransform(168.7,120);

	this.shape_6 = new cjs.Shape();
	this.shape_6.graphics.f("rgba(255,255,255,0.471)").s().p("ApJCMQjyg6AAhSQAAhRDyg7QD0g6FVAAQFXAADyA6QDzA7AABRQAABSjzA6QjyA7lXAAQlVAAj0g7g");
	this.shape_6.setTransform(179,120);

	this.shape_7 = new cjs.Shape();
	this.shape_7.graphics.f("rgba(255,255,255,0.467)").s().p("ApICMQjyg6AAhSQAAhRDyg7QDzg6FVAAQFXAADyA6QDyA7AABRQAABSjyA6QjyA7lXAAQlVAAjzg7g");
	this.shape_7.setTransform(189.2,120);

	this.shape_8 = new cjs.Shape();
	this.shape_8.graphics.f("rgba(255,255,255,0.463)").s().p("ApICMQjyg6AAhSQAAhRDyg7QDzg6FVAAQFXAADxA6QDyA7AABRQAABSjyA6QjxA7lXAAQlVAAjzg7g");
	this.shape_8.setTransform(199.5,120);

	this.shape_9 = new cjs.Shape();
	this.shape_9.graphics.f("rgba(255,255,255,0.459)").s().p("ApHCMQjyg6AAhSQAAhRDyg7QDzg6FUAAQFWAADyA6QDyA7AABRQAABSjyA6QjyA7lWAAQlUAAjzg7g");
	this.shape_9.setTransform(209.7,120);

	this.shape_10 = new cjs.Shape();
	this.shape_10.graphics.f("rgba(255,255,255,0.455)").s().p("ApHCMQjxg6AAhSQAAhRDxg7QDzg6FUAAQFWAADxA6QDyA7AABRQAABSjyA6QjxA7lWAAQlUAAjzg7g");
	this.shape_10.setTransform(220,120);

	this.shape_11 = new cjs.Shape();
	this.shape_11.graphics.f("rgba(255,255,255,0.451)").s().p("ApGCMQjyg6AAhSQAAhRDyg7QDyg6FUAAQFVAADyA6QDyA7AABRQAABSjyA6QjyA7lVAAQlUAAjyg7g");
	this.shape_11.setTransform(230.2,120);

	this.shape_12 = new cjs.Shape();
	this.shape_12.graphics.f("rgba(255,255,255,0.447)").s().p("ApGCMQjxg6AAhSQAAhRDxg7QDyg6FUAAQFVAADxA6QDyA7AABRQAABSjyA6QjxA7lVAAQlUAAjyg7g");
	this.shape_12.setTransform(240.5,120);

	this.shape_13 = new cjs.Shape();
	this.shape_13.graphics.f("rgba(255,255,255,0.443)").s().p("ApFCMQjxg6AAhSQAAhRDxg7QDyg6FTAAQFVAADxA6QDxA7AABRQAABSjxA6QjxA7lVAAQlTAAjyg7g");
	this.shape_13.setTransform(250.7,120);

	this.shape_14 = new cjs.Shape();
	this.shape_14.graphics.f("rgba(255,255,255,0.439)").s().p("ApFCMQjwg6AAhSQAAhRDwg7QDyg6FTAAQFUAADyA6QDxA7gBBRQABBSjxA6QjyA7lUAAQlTAAjyg7g");
	this.shape_14.setTransform(261,120);

	this.shape_15 = new cjs.Shape();
	this.shape_15.graphics.f("rgba(255,255,255,0.431)").s().p("ApFCMQjwg6AAhSQAAhRDwg7QDyg6FTAAQFUAADxA6QDxA7AABRQAABSjxA6QjxA7lUAAQlTAAjyg7g");
	this.shape_15.setTransform(271.3,120);

	this.shape_16 = new cjs.Shape();
	this.shape_16.graphics.f("rgba(255,255,255,0.427)").s().p("ApECMQjwg6AAhSQAAhRDwg7QDyg6FSAAQFUAADwA6QDxA7AABRQAABSjxA6QjwA7lUAAQlSAAjyg7g");
	this.shape_16.setTransform(281.5,120);

	this.shape_17 = new cjs.Shape();
	this.shape_17.graphics.f("rgba(255,255,255,0.424)").s().p("ApECMQjwg6AAhSQAAhRDwg7QDxg6FTAAQFUAADwA6QDwA7ABBRQgBBSjwA6QjwA7lUAAQlTAAjxg7g");
	this.shape_17.setTransform(291.8,120);

	this.shape_18 = new cjs.Shape();
	this.shape_18.graphics.f("rgba(255,255,255,0.42)").s().p("ApDCMQjwg6AAhSQAAhRDwg7QDxg6FSAAQFTAADwA6QDxA7AABRQAABSjxA6QjwA7lTAAQlSAAjxg7g");
	this.shape_18.setTransform(302,120);

	this.shape_19 = new cjs.Shape();
	this.shape_19.graphics.f("rgba(255,255,255,0.416)").s().p("ApCCMQjwg6AAhSQAAhRDwg7QDwg6FSAAQFTAADwA6QDwA7AABRQAABSjwA6QjwA7lTAAQlSAAjwg7g");
	this.shape_19.setTransform(312.3,120);

	this.shape_20 = new cjs.Shape();
	this.shape_20.graphics.f("rgba(255,255,255,0.412)").s().p("ApCCMQjvg6AAhSQAAhRDvg7QDwg6FSAAQFTAADwA6QDvA7AABRQAABSjvA6QjwA7lTAAQlSAAjwg7g");
	this.shape_20.setTransform(322.5,120);

	this.shape_21 = new cjs.Shape();
	this.shape_21.graphics.f("rgba(255,255,255,0.408)").s().p("ApBCMQjwg6AAhSQAAhRDwg7QDwg6FRAAQFTAADvA6QDwA7AABRQAABSjwA6QjvA7lTAAQlRAAjwg7g");
	this.shape_21.setTransform(332.8,120);

	this.shape_22 = new cjs.Shape();
	this.shape_22.graphics.f("rgba(255,255,255,0.404)").s().p("ApBCMQjvg6AAhSQAAhRDvg7QDwg6FRAAQFSAADwA6QDvA7AABRQAABSjvA6QjwA7lSAAQlRAAjwg7g");
	this.shape_22.setTransform(343.1,120);

	this.shape_23 = new cjs.Shape();
	this.shape_23.graphics.f("rgba(255,255,255,0.4)").s().p("ApBCMQjug6AAhSQAAhRDug7QDxg6FQAAQFSAADvA6QDvA7AABRQAABSjvA6QjvA7lSAAQlQAAjxg7g");
	this.shape_23.setTransform(353.3,120);

	this.shape_24 = new cjs.Shape();
	this.shape_24.graphics.f("rgba(255,255,255,0.396)").s().p("ApACMQjvg6AAhSQAAhRDvg7QDvg6FRAAQFSAADuA6QDwA7AABRQAABSjwA6QjuA7lSAAQlRAAjvg7g");
	this.shape_24.setTransform(363.6,120);

	this.shape_25 = new cjs.Shape();
	this.shape_25.graphics.f("rgba(255,255,255,0.388)").s().p("ApACNQjug7AAhSQAAhRDug7QDwg7FQABQFSgBDuA7QDvA7AABRQAABSjvA7QjuA6lSAAQlQAAjwg6g");
	this.shape_25.setTransform(373.8,120.1);

	this.shape_26 = new cjs.Shape();
	this.shape_26.graphics.f("rgba(255,255,255,0.384)").s().p("Ao/CNQjug7AAhSQAAhRDug7QDvg7FQABQFRgBDvA7QDuA7AABRQAABSjuA7QjvA6lRAAQlQAAjvg6g");
	this.shape_26.setTransform(384.1,120.1);

	this.shape_27 = new cjs.Shape();
	this.shape_27.graphics.f("rgba(255,255,255,0.38)").s().p("Ao/CNQjug7AAhSQAAhRDug7QDvg7FQABQFRgBDuA7QDvA7AABRQAABSjvA7QjuA6lRAAQlQAAjvg6g");
	this.shape_27.setTransform(394.3,120.1);

	this.shape_28 = new cjs.Shape();
	this.shape_28.graphics.f("rgba(255,255,255,0.376)").s().p("Ao+CNQjug7AAhSQAAhRDug7QDug7FQABQFRgBDtA7QDvA7AABRQAABSjvA7QjtA6lRAAQlQAAjug6g");
	this.shape_28.setTransform(404.6,120.1);

	this.shape_29 = new cjs.Shape();
	this.shape_29.graphics.f("rgba(255,255,255,0.373)").s().p("Ao+CNQjug7AAhSQAAhRDug7QDvg7FPABQFQgBDuA7QDuA7ABBRQgBBSjuA7QjuA6lQAAQlPAAjvg6g");
	this.shape_29.setTransform(414.9,120.1);

	this.shape_30 = new cjs.Shape();
	this.shape_30.graphics.f("rgba(255,255,255,0.369)").s().p("Ao+CNQjsg7gBhSQABhRDsg7QDvg7FPABQFQgBDtA7QDvA7AABRQAABSjvA7QjtA6lQAAQlPAAjvg6g");
	this.shape_30.setTransform(425.1,120.1);

	this.shape_31 = new cjs.Shape();
	this.shape_31.graphics.f("rgba(255,255,255,0.365)").s().p("Ao9CNQjtg7AAhSQAAhRDtg7QDug7FPABQFQgBDtA7QDuA7AABRQAABSjuA7QjtA6lQAAQlPAAjug6g");
	this.shape_31.setTransform(435.4,120.1);

	this.shape_32 = new cjs.Shape();
	this.shape_32.graphics.f("rgba(255,255,255,0.361)").s().p("Ao8CNQjtg7AAhSQAAhRDtg7QDug7FOABQFPgBDuA7QDtA7AABRQAABSjtA7QjuA6lPAAQlOAAjug6g");
	this.shape_32.setTransform(445.6,120.1);

	this.shape_33 = new cjs.Shape();
	this.shape_33.graphics.f("rgba(255,255,255,0.357)").s().p("Ao8CNQjtg7AAhSQAAhRDtg7QDug7FOABQFPgBDtA7QDuA7AABRQAABSjuA7QjtA6lPAAQlOAAjug6g");
	this.shape_33.setTransform(455.9,120.1);

	this.shape_34 = new cjs.Shape();
	this.shape_34.graphics.f("rgba(255,255,255,0.353)").s().p("Ao7CNQjtg7AAhSQAAhRDtg7QDtg7FOABQFPgBDtA7QDtA7AABRQAABSjtA7QjtA6lPAAQlOAAjtg6g");
	this.shape_34.setTransform(466.1,120.1);

	this.shape_35 = new cjs.Shape();
	this.shape_35.graphics.f("rgba(255,255,255,0.345)").s().p("Ao7CNQjsg7AAhSQAAhRDsg7QDug7FNABQFPgBDsA7QDtA7AABRQAABSjtA7QjsA6lPAAQlNAAjug6g");
	this.shape_35.setTransform(476.4,120.1);

	this.shape_36 = new cjs.Shape();
	this.shape_36.graphics.f("rgba(255,255,255,0.341)").s().p("Ao6CNQjtg7AAhSQAAhRDtg7QDsg7FOABQFPgBDsA7QDtA7AABRQAABSjtA7QjsA6lPAAQlOAAjsg6g");
	this.shape_36.setTransform(486.7,120.1);

	this.shape_37 = new cjs.Shape();
	this.shape_37.graphics.f("rgba(255,255,255,0.337)").s().p("Ao6CNQjsg7AAhSQAAhRDsg7QDtg7FNABQFOgBDtA7QDsA7AABRQAABSjsA7QjtA6lOAAQlNAAjtg6g");
	this.shape_37.setTransform(496.9,120.1);

	this.shape_38 = new cjs.Shape();
	this.shape_38.graphics.f("rgba(255,255,255,0.333)").s().p("Ao5CNQjsg7AAhSQAAhRDsg7QDsg7FNABQFOgBDsA7QDsA7AABRQAABSjsA7QjsA6lOAAQlNAAjsg6g");
	this.shape_38.setTransform(507.2,120.1);

	this.shape_39 = new cjs.Shape();
	this.shape_39.graphics.f("rgba(255,255,255,0.329)").s().p("Ao5CNQjrg7gBhSQABhRDrg7QDtg7FMABQFOgBDrA7QDtA7gBBRQABBSjtA7QjrA6lOAAQlMAAjtg6g");
	this.shape_39.setTransform(517.4,120.1);

	this.shape_40 = new cjs.Shape();
	this.shape_40.graphics.f("rgba(255,255,255,0.325)").s().p("Ao5CNQjrg7AAhSQAAhRDrg7QDtg7FMABQFNgBDsA7QDsA7AABRQAABSjsA7QjsA6lNAAQlMAAjtg6g");
	this.shape_40.setTransform(527.7,120.1);

	this.shape_41 = new cjs.Shape();
	this.shape_41.graphics.f("rgba(255,255,255,0.322)").s().p("Ao4CNQjrg7AAhSQAAhRDrg7QDsg7FMABQFNgBDrA7QDsA7AABRQAABSjsA7QjrA6lNAAQlMAAjsg6g");
	this.shape_41.setTransform(537.9,120.1);

	this.shape_42 = new cjs.Shape();
	this.shape_42.graphics.f("rgba(255,255,255,0.318)").s().p("Ao4CNQjqg7AAhSQAAhRDqg7QDsg7FMABQFMgBDsA7QDrA7AABRQAABSjrA7QjsA6lMAAQlMAAjsg6g");
	this.shape_42.setTransform(548.2,120.1);

	this.shape_43 = new cjs.Shape();
	this.shape_43.graphics.f("rgba(255,255,255,0.314)").s().p("Ao3CNQjrg7AAhSQAAhRDrg7QDsg7FLABQFNgBDrA7QDrA7AABRQAABSjrA7QjrA6lNAAQlLAAjsg6g");
	this.shape_43.setTransform(558.4,120.1);

	this.shape_44 = new cjs.Shape();
	this.shape_44.graphics.f("rgba(255,255,255,0.31)").s().p("Ao2CNQjrg7AAhSQAAhRDrg7QDrg7FLABQFMgBDrA7QDrA7AABRQAABSjrA7QjrA6lMAAQlLAAjrg6g");
	this.shape_44.setTransform(568.7,120.1);

	this.shape_45 = new cjs.Shape();
	this.shape_45.graphics.f("rgba(255,255,255,0.302)").s().p("Ao2CNQjqg7AAhSQAAhRDqg7QDrg7FLABQFMgBDrA7QDqA7ABBRQgBBSjqA7QjrA6lMAAQlLAAjrg6g");
	this.shape_45.setTransform(579,120.1);

	this.shape_46 = new cjs.Shape();
	this.shape_46.graphics.f("rgba(255,255,255,0.298)").s().p("Ao2CNQjqg7AAhSQAAhRDqg7QDrg7FLABQFLgBDrA7QDrA7AABRQAABSjrA7QjrA6lLAAQlLAAjrg6g");
	this.shape_46.setTransform(589.2,120.1);

	this.shape_47 = new cjs.Shape();
	this.shape_47.graphics.f("rgba(255,255,255,0.294)").s().p("Ao1CNQjqg7AAhSQAAhRDqg7QDrg7FKABQFMgBDqA7QDqA7AABRQAABSjqA7QjqA6lMAAQlKAAjrg6g");
	this.shape_47.setTransform(599.5,120.1);

	this.shape_48 = new cjs.Shape();
	this.shape_48.graphics.f("rgba(255,255,255,0.29)").s().p("Ao1CNQjpg7AAhSQAAhRDpg7QDrg7FKABQFLgBDqA7QDqA7AABRQAABSjqA7QjqA6lLAAQlKAAjrg6g");
	this.shape_48.setTransform(609.7,120.1);

	this.shape_49 = new cjs.Shape();
	this.shape_49.graphics.f("rgba(255,255,255,0.286)").s().de(-95,-25,190,50);
	this.shape_49.setTransform(620,120.1,0.841,0.8);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.shape}]}).to({state:[{t:this.shape_1}]},1).to({state:[{t:this.shape_2}]},1).to({state:[{t:this.shape_3}]},1).to({state:[{t:this.shape_4}]},1).to({state:[{t:this.shape_5}]},1).to({state:[{t:this.shape_6}]},1).to({state:[{t:this.shape_7}]},1).to({state:[{t:this.shape_8}]},1).to({state:[{t:this.shape_9}]},1).to({state:[{t:this.shape_10}]},1).to({state:[{t:this.shape_11}]},1).to({state:[{t:this.shape_12}]},1).to({state:[{t:this.shape_13}]},1).to({state:[{t:this.shape_14}]},1).to({state:[{t:this.shape_15}]},1).to({state:[{t:this.shape_16}]},1).to({state:[{t:this.shape_17}]},1).to({state:[{t:this.shape_18}]},1).to({state:[{t:this.shape_19}]},1).to({state:[{t:this.shape_20}]},1).to({state:[{t:this.shape_21}]},1).to({state:[{t:this.shape_22}]},1).to({state:[{t:this.shape_23}]},1).to({state:[{t:this.shape_24}]},1).to({state:[{t:this.shape_25}]},1).to({state:[{t:this.shape_26}]},1).to({state:[{t:this.shape_27}]},1).to({state:[{t:this.shape_28}]},1).to({state:[{t:this.shape_29}]},1).to({state:[{t:this.shape_30}]},1).to({state:[{t:this.shape_31}]},1).to({state:[{t:this.shape_32}]},1).to({state:[{t:this.shape_33}]},1).to({state:[{t:this.shape_34}]},1).to({state:[{t:this.shape_35}]},1).to({state:[{t:this.shape_36}]},1).to({state:[{t:this.shape_37}]},1).to({state:[{t:this.shape_38}]},1).to({state:[{t:this.shape_39}]},1).to({state:[{t:this.shape_40}]},1).to({state:[{t:this.shape_41}]},1).to({state:[{t:this.shape_42}]},1).to({state:[{t:this.shape_43}]},1).to({state:[{t:this.shape_44}]},1).to({state:[{t:this.shape_45}]},1).to({state:[{t:this.shape_46}]},1).to({state:[{t:this.shape_47}]},1).to({state:[{t:this.shape_48}]},1).to({state:[{t:this.shape_49}]},1).wait(1));

	// Cloud
	this.shape_50 = new cjs.Shape();
	this.shape_50.graphics.f("rgba(255,255,255,0.498)").s().de(-95,-25,190,50);
	this.shape_50.setTransform(-80,60,1.316,1.2);

	this.shape_51 = new cjs.Shape();
	this.shape_51.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQluhXAAh8QAAh7FuhYQFvhYIEAAQIFAAFuBYQFvBYAAB7QAAB8lvBXQluBZoFAAQoEAAlvhZg");
	this.shape_51.setTransform(-67.1,60);
	this.shape_51._off = true;

	this.shape_52 = new cjs.Shape();
	this.shape_52.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQlthXAAh8QAAh7FthYQFuhYIFAAQIFAAFuBYQFuBYABB7QgBB8luBXQluBZoFAAQoFAAluhZg");
	this.shape_52.setTransform(-54.3,60);
	this.shape_52._off = true;

	this.shape_53 = new cjs.Shape();
	this.shape_53.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQlthXAAh8QAAh7FthYQFvhYIEAAQIFAAFuBYQFuBYAAB7QAAB8luBXQluBZoFAAQoEAAlvhZg");
	this.shape_53.setTransform(-41.4,60);
	this.shape_53._off = true;

	this.shape_54 = new cjs.Shape();
	this.shape_54.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQlthXAAh8QAAh7FthYQFuhYIFAAQIFAAFuBYQFvBYAAB7QAAB8lvBXQluBZoFAAQoFAAluhZg");
	this.shape_54.setTransform(-28.5,60);
	this.shape_54._off = true;

	this.shape_55 = new cjs.Shape();
	this.shape_55.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQlthXAAh8QAAh7FthYQFuhYIFAAQIFAAFuBYQFuBYAAB7QAAB8luBXQluBZoFAAQoFAAluhZg");
	this.shape_55.setTransform(-15.7,60);
	this.shape_55._off = true;

	this.shape_56 = new cjs.Shape();
	this.shape_56.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQluhXAAh8QAAh7FuhYQFvhYIEAAQIFAAFuBYQFuBYAAB7QAAB8luBXQluBZoFAAQoEAAlvhZg");
	this.shape_56.setTransform(-2.8,60);
	this.shape_56._off = true;

	this.shape_57 = new cjs.Shape();
	this.shape_57.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQluhXAAh8QAAh7FuhYQFuhYIFAAQIFAAFuBYQFvBYAAB7QAAB8lvBXQluBZoFAAQoFAAluhZg");
	this.shape_57.setTransform(10,60);

	this.shape_58 = new cjs.Shape();
	this.shape_58.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQluhXAAh8QAAh7FuhYQFuhYIFAAQIFAAFuBYQFuBYABB7QgBB8luBXQluBZoFAAQoFAAluhZg");
	this.shape_58.setTransform(190,60);

	this.shape_59 = new cjs.Shape();
	this.shape_59.graphics.f("rgba(255,255,255,0.498)").s().p("AtzDTQluhXABh8QgBh7FuhYQFvhYIEAAQIFAAFuBYQFvBYAAB7QAAB8lvBXQluBZoFAAQoEAAlvhZg");
	this.shape_59.setTransform(382.9,60);

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.shape_50,p:{x:-80}}]}).to({state:[{t:this.shape_51}]},1).to({state:[{t:this.shape_52}]},1).to({state:[{t:this.shape_53}]},1).to({state:[{t:this.shape_54}]},1).to({state:[{t:this.shape_55}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_57,p:{x:10}}]},1).to({state:[{t:this.shape_51}]},1).to({state:[{t:this.shape_52}]},1).to({state:[{t:this.shape_53}]},1).to({state:[{t:this.shape_54}]},1).to({state:[{t:this.shape_55}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_57,p:{x:100}}]},1).to({state:[{t:this.shape_51}]},1).to({state:[{t:this.shape_52}]},1).to({state:[{t:this.shape_53}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_55}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_58,p:{x:190}}]},1).to({state:[{t:this.shape_51}]},1).to({state:[{t:this.shape_52}]},1).to({state:[{t:this.shape_53}]},1).to({state:[{t:this.shape_54}]},1).to({state:[{t:this.shape_55}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_58,p:{x:280}}]},1).to({state:[{t:this.shape_51}]},1).to({state:[{t:this.shape_52}]},1).to({state:[{t:this.shape_51}]},1).to({state:[{t:this.shape_54}]},1).to({state:[{t:this.shape_55}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_58,p:{x:370}}]},1).to({state:[{t:this.shape_59,p:{x:382.9}}]},1).to({state:[{t:this.shape_52}]},1).to({state:[{t:this.shape_53}]},1).to({state:[{t:this.shape_54}]},1).to({state:[{t:this.shape_55}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_57,p:{x:460}}]},1).to({state:[{t:this.shape_59,p:{x:472.9}}]},1).to({state:[{t:this.shape_52}]},1).to({state:[{t:this.shape_53}]},1).to({state:[{t:this.shape_54}]},1).to({state:[{t:this.shape_55}]},1).to({state:[{t:this.shape_56}]},1).to({state:[{t:this.shape_50,p:{x:550}}]},1).wait(1));
	this.timeline.addTween(cjs.Tween.get(this.shape_51).wait(1).to({_off:false},0).to({_off:true},1).wait(6).to({_off:false,x:22.9},0).to({_off:true},1).wait(6).to({_off:false,x:112.9},0).to({_off:true},1).wait(6).to({_off:false,x:202.9},0).to({_off:true},1).wait(6).to({_off:false,x:292.9},0).to({_off:true},1).wait(1).to({_off:false,x:318.6},0).to({_off:true},1).wait(18));
	this.timeline.addTween(cjs.Tween.get(this.shape_52).wait(2).to({_off:false},0).to({_off:true},1).wait(6).to({_off:false,x:35.7},0).to({_off:true},1).wait(6).to({_off:false,x:125.7},0).to({_off:true},1).wait(6).to({_off:false,x:215.7},0).to({_off:true},1).wait(6).to({_off:false,x:305.7},0).to({_off:true},1).wait(6).to({_off:false,x:395.7},0).to({_off:true},1).wait(6).to({_off:false,x:485.7},0).to({_off:true},1).wait(5));
	this.timeline.addTween(cjs.Tween.get(this.shape_53).wait(3).to({_off:false},0).to({_off:true},1).wait(6).to({_off:false,x:48.6},0).to({_off:true},1).wait(6).to({_off:false,x:138.6},0).to({_off:true},1).wait(6).to({_off:false,x:228.6},0).to({_off:true},1).wait(13).to({_off:false,x:408.6},0).to({_off:true},1).wait(6).to({_off:false,x:498.6},0).to({_off:true},1).wait(4));
	this.timeline.addTween(cjs.Tween.get(this.shape_54).wait(4).to({_off:false},0).to({_off:true},1).wait(6).to({_off:false,x:61.5},0).to({_off:true},1).wait(13).to({_off:false,x:241.5},0).to({_off:true},1).wait(6).to({_off:false,x:331.5},0).to({_off:true},1).wait(6).to({_off:false,x:421.5},0).to({_off:true},1).wait(6).to({_off:false,x:511.5},0).to({_off:true},1).wait(3));
	this.timeline.addTween(cjs.Tween.get(this.shape_55).wait(5).to({_off:false},0).to({_off:true},1).wait(6).to({_off:false,x:74.3},0).to({_off:true},1).wait(6).to({_off:false,x:164.3},0).to({_off:true},1).wait(6).to({_off:false,x:254.3},0).to({_off:true},1).wait(6).to({_off:false,x:344.3},0).to({_off:true},1).wait(6).to({_off:false,x:434.3},0).to({_off:true},1).wait(6).to({_off:false,x:524.3},0).to({_off:true},1).wait(2));
	this.timeline.addTween(cjs.Tween.get(this.shape_56).wait(6).to({_off:false},0).to({_off:true},1).wait(6).to({_off:false,x:87.2},0).to({_off:true},1).wait(4).to({_off:false,x:151.4},0).to({_off:true},1).wait(1).to({_off:false,x:177.2},0).to({_off:true},1).wait(6).to({_off:false,x:267.2},0).to({_off:true},1).wait(6).to({_off:false,x:357.2},0).to({_off:true},1).wait(6).to({_off:false,x:447.2},0).to({_off:true},1).wait(6).to({_off:false,x:537.2},0).to({_off:true},1).wait(1));

	// Background
	this.shape_60 = new cjs.Shape();
	this.shape_60.graphics.lf(["#2AA823","#096900"],[0,1],0,45,0,-45).s().dr(-320,-45,640,90);
	this.shape_60.setTransform(320,315);

	this.instance_1 = new lib.sky_background();

	this.timeline.addTween(cjs.Tween.get({}).to({state:[{t:this.instance_1},{t:this.shape_60}]}).wait(50));

}).prototype = p = new cjs.MovieClip();
p.nominalBounds = new cjs.Rectangle(115,180,930,360);

})(lib = lib||{}, images = images||{}, createjs = createjs||{});
var lib, images, createjs;