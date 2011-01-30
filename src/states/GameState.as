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
		private var _cooldownTime:Number = 0.0;
		
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
			
			_player1 = new PlayerSprite("blue", "F", "G", FlxSprite.RIGHT, FlxG.width * 0.25, 120);
			_player2 = new PlayerSprite("red", "H", "J", FlxSprite.RIGHT, FlxG.width * 0.25, 120);
			
			
			
			_player1Strip = new PlayerGroup(_player1);
			_player1Strip.y = 0;
			add(_player1Strip);
			
			_player2Strip = new PlayerGroup(_player2);
			_player2Strip.y = FlxG.height * 0.5;
			add(_player2Strip);		
			
			_bgm = FlxG.play(Assets.BgmSound);
		}
		
		override public function update():void
		{
			if (!_bgm.playing && !_endTriggered)
			{
				_cooldownTime += FlxG.elapsed;
				if (_cooldownTime > 5.0)
				{
					_endTriggered = true;
					FlxG.log("Music Ends!");
					
					FlxG.fade.start(0xff000000, 2.0, onFadeDone);
				}
			}
			
			// Temp: To Remove
			if (FlxG.keys.justPressed("ONE"))
			{
				onFadeDone();
			}
			
			if (FlxG.keys.justPressed("TWO"))
			{
				_player1Strip.nextSeason();
				_player2Strip.nextSeason();
			}
			
			super.update();
		}
		
		private function onFadeDone():void
		{
			_player1Strip.goToScore();
			_player2Strip.goToScore();
			
			FlxG.flash.start(0xff000000, 2.0);
		}
		
	}
}