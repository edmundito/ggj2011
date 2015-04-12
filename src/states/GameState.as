package states 
{
	import org.flixel.*;
	
	import sprites.*;
	
	import world.*;
	
	public class GameState extends FlxState 
	{
		private var _player1:PlayerSprite;
		private var _player2:PlayerSprite;
		private var _player1Strip:PlayerGroup;
		private var _player2Strip:PlayerGroup;
		
		private var _bgm:FlxSound;
		private var _endTriggered:Boolean = false;
		private var _seasonTimer:Number = 20.0; //85.0; // 85.0 = Original music length before starting to change seasons.
		
		private var _fadeoutCalled:Boolean = false;
		private var _fadeOutDelay:Number = 0.0;
		
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
			Globals.randomKeyMgr.addKeyToIgnoreList("U");
			Globals.randomKeyMgr.addKeyToIgnoreList("V");

			_player1 = new PlayerSprite("blue", "F", "G", FlxSprite.RIGHT, FlxG.width * 0.25, 120);
			_player2 = new PlayerSprite("red", "H", "J", FlxSprite.RIGHT, FlxG.width * 0.25, 120);

			_player1Strip = new PlayerGroup(_player1);
			_player1Strip.y = 0;
			add(_player1Strip);

			_player2Strip = new PlayerGroup(_player2);
			_player2Strip.y = FlxG.height * 0.5;
			add(_player2Strip);
		}
		
		override public function update():void
		{
			if (_player1Strip.complete && _player2Strip.complete && !_fadeoutCalled)
			{
				if (_fadeOutDelay >= 5.0)
				{
					_fadeoutCalled = true;
					FlxG.fade.start(0xff000000, 5.0, onEndFadeComplete);
				}
				_fadeOutDelay += FlxG.elapsed;
			}

			if (_bgm == null)
			{
				if (_player1.pressedMoveKeys || _player2.pressedMoveKeys)
				{
					_bgm = FlxG.play(Assets.BgmSound);
				}
			}
			else
			{
				if (!_bgm.playing && !_endTriggered)
				{
					_endTriggered = true;
					FlxG.log("Music Ends!");
					goToScore();
				}
				else
				{
					if (_seasonTimer <= 0 )
					{
						_player1Strip.nextSeason();
						_player2Strip.nextSeason();
					}
					else
					{
						_seasonTimer -= FlxG.elapsed;
					}
				}
			}
			
			super.update();
		}
		
		private function goToScore():void
		{
			_player1Strip.goToScore();
			_player2Strip.goToScore();

			FlxG.flash.start(0xff000000, 2.0);
			if (_bgm.playing)
			{
				_bgm.stop();
			}
			_bgm = FlxG.play(Assets.BgmSlowSound, 1.0, true);
		}
		
		private function onEndFadeComplete():void
		{
			FlxG.log("Fade1 done!");
			FlxG.state = new MainMenuState();
		}
	}
}