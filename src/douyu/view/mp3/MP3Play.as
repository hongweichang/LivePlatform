package douyu.view.mp3
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	
	import douyu.data.InfoData;
	import douyu.data.vo.MusicData;
	
	public class MP3Play extends Sprite
	{
		private var infodata:InfoData=InfoData.instant;
		private var sound:Sound;
		private var soundCh:SoundChannel;
		private var req:URLRequest;
		private var backGround:MP3background;
		
		public function MP3Play()
		{
			super();
			init();
		}
		
		private function init():void{
			
			//
			req = new URLRequest();
			var rhArray:Array = new Array();
			rhArray.push(new URLRequestHeader("Referer",'http://www.baidu.com'));
			req.requestHeaders=rhArray;
			//
			backGround=MP3background.instant;
			this.addChild(backGround);
		}
		
		public  function PlaySound(md:MusicData):void
		{   
//			infodata.playMusicdata=md;
			req.url=md.musicUrl;
			
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE,onloadComplete);
			sound.load(req);
			
			soundCh = sound.play();
			soundCh.addEventListener(Event.SOUND_COMPLETE,soundPlayComplete);
			
			backGround.playBackground();
		}
		
		protected function soundPlayComplete(event:Event):void
		{
			StopSound();
			infodata.music_stop();
		}
		
		protected function onloadComplete(event:Event):void
		{
			sound.removeEventListener(Event.COMPLETE,onloadComplete);
			if(infodata.playMusicdata.musicTime==0){
				infodata.playMusicdata.musicTime=Math.round(sound.length/1000);	
			}
		}
		
		public function StopSound():void{
			soundCh.stop();
			backGround.stopBackground();
		}
		
		
		
		
		
		private static var _instant:MP3Play;
		
		public static function get instant():MP3Play
		{
			if( null == _instant )
			{
				_instant = new MP3Play();
			}
			return _instant;
		}
	}
}