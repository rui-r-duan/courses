//replace port 8080 below if you wish to change the server port
var serverport = 8080;

var http = require('http');
var qs = require('querystring');
var url = require('url');
var fs = require('fs');
var util = require('util');
var mime = require('mime');

var vidStreamer = require("vid-streamer");

//write back result
writeResult = function(res, code, result, mimetype) {
  res.writeHead(code, {'Content-Type': mimetype,'Content-Length':result.length});
  res.write(result);
  res.end();
}

// get getFilename from request using url
getFilename = function(req) {
  var filename=req.url.substring(1);
  if (!!filename) return filename;
  return "/";
}

// sendFile 
sendFile = function(filename, res) {  
  if (filename[filename.length-1] === '/') filename += 'index.html'
  fs.readFile(filename, function (err, data) {
    if (err){
      writeResult(res, "404", "Page not found!", "text/plain");
      return;
    }
//    console.log('file: ' + filename + ' mime : ' + mime.lookup(filename));    
    writeResult(res, 200, data, mime.lookup(filename));
  });
}

// the GET handler
handleGet = function(req, res) {
  var filename=getFilename(req).replace(/%20/g, " ");
  if (req.url === "/") {
    writeResult(res, "200", "jQM Server says: Congrats!", "text/plain");  	
  }
  else if (req.url === "/getScores") {
    sendScores(req, res);
  }
  else if (req.url === "/delay") {
    setTimeout(function(){
      sendFile('dummypage', res);
    }, 2000);
  }
  else if (req.url.indexOf("/resources/video") >= 0
  	|| req.url.indexOf("/resources/audio") >= 0	) {
    vidStreamer(req, res);
  } else {
    sendFile(filename, res);
  }
}
 
//Handles /postComment
addComment = function(req, res) {
  var body="";
  req.on('data', function (data) {
    body += data;
  });
  req.on('end', function () {
    var creds = qs.parse(body);
    var str = "<div data-role='page' data-theme='a'><div data-role='header'><h1>Comments Added</h1></div>"
      + "<div data-role='content'>Hi " + creds.username + "!"
      + "<p>Your Email ID: " + creds.email + "</p>"
      + "<p>Added your comment: " + creds.comments + "</p>"
      + "<a href='#' data-role='button' data-rel='back'>Back</a></div></div>";
    writeResult(res, "200", str, "text/html");
  });
}

// HTTP REQUEST HANDLERS
handlePost = function(req, res) {
  if (req.url === "/postComment") {
    addComment(req, res);
  } else {
    var str = "<div data-role='dialog'><div data-role='header'><h1>Server Response</h1></div>"
      + "<div data-role='content'>Your post was successful!</div></div>";
    writeResult(res, "200", str, "text/html");
    
  }
}

// server starts here
http.createServer(function (req, res) {  
  if (req.method == 'GET' ) {
    handleGet(req, res);  
  }
  else 
  if ( req.method == 'POST' ) {
    handlePost(req, res);
  } 
}).listen(serverport);
util.log('jQuery Mobile Server is running...');
