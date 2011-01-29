package oldStates
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	
	import sprites.PlayerSprite;
	
	public class TestPlayerState extends FlxState
	{
		private var _player:PlayerSprite;
		
		override public function create():void
		{
			_player = new PlayerSprite("L", "A", FlxSprite.RIGHT, 0, FlxG.height * 0.25);
			add(_player);
			
			_player = new PlayerSprite("G", "H", FlxSprite.LEFT, FlxG.width, FlxG.height * 0.75);
			add(_player);
		}
		
		override public function update():void
		{
			if (_player.x > FlxG.width && _player.facing == FlxSprite.RIGHT)
			{
				_player.x = 0;
			}
			
			if (_player.x < 0 && _player.facing == FlxSprite.LEFT)
			{
				_player.x = FlxG.width;
			}
			
			super.update();
		}
	}
}