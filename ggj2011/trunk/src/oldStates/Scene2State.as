package oldStates 
{
	import org.flixel.*;
	import flash.utils.*;
	
	public class Scene2State extends GameState 
	{
		
		override public function create():void 
		{
			super.create();
			
			// State name
			add(new FlxText(0, 0, 100, "Hello, Scene 2!")); //adds a 100px wide text field at position 0,0 (upper left)
			
			initScene();
			_leftScene = Scene1State;
			
			// Start state
			FlxG.flash.start(0xffffffff, FLASHFADETIME);
		}

		public function initScene():void
		{
			if (_prevState is Scene1State)
			{
				addPlayer(SAFEBUFFER, GROUND);
				_player.facing = FlxSprite.LEFT;
			}
		}
		
		override public function update():void
		{
			super.update();
		}
	}

}