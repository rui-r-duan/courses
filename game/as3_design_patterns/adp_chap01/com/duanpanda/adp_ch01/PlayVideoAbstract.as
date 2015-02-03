package com.duanpanda.adp_ch01 
{
	import flash.display.Sprite;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	public class PlayVideoAbstract extends Sprite 
	{
		
		public function PlayVideoAbstract(nc:NetConnection, ns:NetStream,
			vid:Video, flick:String, xpos:uint, ypos:uint) 
		{
			nc = new NetConnection();
			nc.connect(null);
			ns = new NetStream(nc);
			vid = new Video();
			vid.attachNetStream(ns);
			ns.play(flick);
			vid.x = xpos;
			vid.y = ypos;
			addChild(vid);
		}
		
	}

}