package world 
{	
	import org.flixel.FlxSprite;
	
	public class Background extends FlxSprite 
	{
		static private const MAX_FRAMES:uint = 6;
		static private const WINTER_FRAMES:uint = 2;
		static private const SPRING_FRAMES:uint = 3;
		
		private var _current:int = 0;
		private var _phase:uint = 0;
		
		static private const MAX_PHASES = 3;
		
		public function Background(Graphic:Class, height:uint = 120) 
		{
			super();
			
			loadGraphic(Graphic, true, true, 320, height, true);
			
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
		
		public function nextSeason():void
		{
			if (_phase == 0)
			{
				_phase++;
			}
		}
		
		public function next():Boolean
		{
			if (_phase == 1)
			{
				this.facing = RIGHT;
				_current = 2;
			}
			else
			{
				var choice:uint = Utils.randInt(0, 1);
				this.facing = choice? LEFT : RIGHT;
			}
			
			play(_current.toString());
			
			
			// Increment counter
			_current++;
			
			if (_phase == 0 && _current >= WINTER_FRAMES)
			{
				_current = 0;
			}
			else if (_phase == 1)
			{
				_phase++;
			}
			else if (_phase == 2 && _current >= MAX_FRAMES)
			{
				_current = WINTER_FRAMES + 1;
			}
			
			return true;
		}
		
	}

}