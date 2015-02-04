package com.duanpanda.adp_ch01
{
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.media.Video;
	import flash.display.Sprite;
	
	public class PlayVideo extends Sprite
	{
		public function PlayVideo()
		{
			var nc:NetConnection = new NetConnection();
			nc.connect(null);
			var ns:NetStream = new NetStream(nc);
				var vid:Video = new Video();
				vid.attachNetStream(ns);
				ns.play("adp.flv");
				addChild(vid);
				vid.x = 100;
				vid.y = 50;
		}
	}
}