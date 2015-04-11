package states 
{
	import org.flixel.*;
	
	import sprites.*;
	
	import world.*;
	
	public class GameState extends FlxState 
	{
		private var _player1Strip:PlayerGroup;
		private var _player2Strip:PlayerGroup;
		
		private var _bgm:FlxSound;
		private var _endTriggered:Boolean = false;
		private var _seasonTimer:Number = 85.0;
		
		private var _fadeoutCalled:Boolean = false;
		
		override public function create():void
		{
			Globals.randomKeyMgr.addKeyToIgnoreList("Q");
			Globals.randomKeyMgr.addKeyToIgnoreList("A");
			Globals.randomKeyMgr.addKeyToIgnoreList("Z");
			Globals.randomKeyMgr.addKeyToIgnoreList("W");
			Globals.randomKeyMgr.addKeyToIgnoreList("S");
			Globals.randomKeyMgr.addKeyToIgnoreList("X");
			Globals.randomKeyMgr.addKeyToIgnoreList("P");
			Globals.randomKeyMgr.addKeyToIgnoreList("L");

			var player1:PlayerSprite = new PlayerSprite("blue", "F", "G", FlxSprite.RIGHT, FlxG.width * 0.25, 120);
			var player2:PlayerSprite = new PlayerSprite("red", "H", "J", FlxSprite.RIGHT, FlxG.width * 0.25, 120);

			_player1Strip = new PlayerGroup(player1);
			_player1Strip.y = 0;
			add(_player1Strip);

			_player2Strip = new PlayerGroup(player2);
			_player2Strip.y = FlxG.height * 0.5;
			add(_player2Strip);

			_bgm = FlxG.play(Assets.BgmSound);
		}
		
		override public function update():void
		{
			if (_player1Strip._complete && _player2Strip._complete && !_fadeoutCalled)
			{
				_fadeoutCalled = true;
				FlxG.fade.start(0xff000000, 20.0, onFade1Done);
			}
			
			if (!_bgm.playing && !_endTriggered)
			{
				_endTriggered = true;
				FlxG.log("Music Ends!");
				onFadeDone();
			}
			
			if (_seasonTimer <= 0 )
			{
				_player1Strip.nextSeason();
				_player2Strip.nextSeason();
			}
			else
			{
				_seasonTimer -= FlxG.elapsed;
			}
			
			super.update();
		}
		
		private function onFadeDone():void
		{
			FlxG.log("Fade done!");
			_player1Strip.goToScore();
			_player2Strip.goToScore();

			FlxG.flash.start(0xff000000, 2.0);
			if (_bgm.playing)
			{
				_bgm.stop();
			}
			_bgm = FlxG.play(Assets.BgmSlowSound, 1.0, true);
		}
		
		private function onFade1Done():void
		{
			FlxG.log("Fade1 done!");
			FlxG.state = new LogoState();
		}
	}
}