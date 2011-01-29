package states 
{
	import org.flixel.*;
	
	public class Scene1State extends GameState 
	{
		
	
		override public function create():void 
		{
			super.create();
			
			// State name
			add(new FlxText(0, 0, 100, "Hello, Scene 1!")); //adds a 100px wide text field at position 0,0 (upper left)
			
			initScene();
			_rightScene = Scene2State;
			
			// Start state
			FlxG.flash.start(0xffffffff, FLASHFADETIME);
			
		}
		
		public function initScene():void
		{
			if (_worldTimer._turn == 0)
			{
				addPlayer(FlxG.width * 0.5, GROUND);
			}
			else
			{
				addPlayer(FlxG.width - SAFEBUFFER, GROUND);
			}
		}

		override public function update():void
		{
			super.update();
		}

	}

}