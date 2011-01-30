package world 
{	
	import org.flixel.FlxSprite;
	
	public class Background extends FlxSprite 
	{
		private var _current:int = 0;
		private var MAX_FRAMES:uint = 6;
		
		public function Background(Graphic:Class, height:uint = 120) 
		{
			super();
			
			loadGraphic(Graphic, true, false, 320, height, true);
			
			this.width = 320;
			this.height = height;
			this.offset.x = 0;
			this.offset.y = 0;
			
			addAnimation("0", [0]);
			addAnimation("1", [1]);
			addAnimation("2", [2]);
			addAnimation("3", [3]);
			addAnimation("4", [4]);
			addAnimation("5", [5]);
			
			
			this.fixed = true;
		}
		
		public function next():Boolean
		{
			play(_current.toString())
			
			_current++;
			
			if (_current >= MAX_FRAMES)
			{
				_current = 0;
			}
			
			return true;
		}
		
	}

}