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
		
		override public function create():void
		{
			
			// State name
			add(new FlxText(0, 0, 100, "Hello, World!")); //adds a 100px wide text field at position 0,0 (upper left)
			
			_player1 = new PlayerSprite("blue", "L", "A", FlxSprite.RIGHT, 20, 90);
			_player2 = new PlayerSprite("red", "H", "G", FlxSprite.RIGHT, 20, 90);
			
			_player1Strip = new PlayerGroup(_player1);
			_player1Strip.y = 0;
			add(_player1Strip);
			
			_player2Strip = new PlayerGroup(_player2);
			_player2Strip.y = FlxG.height * 0.5;
			add(_player2Strip);			
		}
		
		override public function update():void
		{			
			super.update();
		}
		
	}
}