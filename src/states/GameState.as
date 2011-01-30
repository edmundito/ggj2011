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
			_player1 = new PlayerSprite("blue", "A", "S", FlxSprite.RIGHT, FlxG.width * 0.25, 120);
			_player2 = new PlayerSprite("red", "K", "L", FlxSprite.RIGHT, FlxG.width * 0.25, 120);
			
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
				}
			}
			
			super.update();
		}
		
	}
}