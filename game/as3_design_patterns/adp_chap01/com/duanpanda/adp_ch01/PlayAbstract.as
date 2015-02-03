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
	public class PlayAbstract extends Sprite 
	{
		private var conn:NetConnection;
		private var stream:NetStream;
		private var vid:Video;
		private var flick:String = "adp.flv";
		
		public function PlayAbstract() 
		{
			super();
			var playIt:PlayVideoAbstract = new PlayVideoAbstract(conn, stream,
				vid, flick, 100, 50);
			addChild(playIt);
		}
		
	}

}