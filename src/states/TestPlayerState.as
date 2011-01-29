package states
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	import sprites.PlayerSprite;
	
	public class TestPlayerState extends FlxState
	{
		private var _player:PlayerSprite;
		
		override public function create():void
		{
			_player = new PlayerSprite(FlxG.width * 0.5, FlxG.height * 0.5);
			add(_player);
		}
	}
}