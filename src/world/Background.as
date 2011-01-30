package world 
{
	import org.flixel.FlxSprite;
	import Assets;
	
	public class Background extends FlxSprite 
	{
		private var current:int = 0;
		
		public function Background() 
		{
			super();
			
			this.fixed = true;
		}
		
		public function next():Boolean
		{
			if (current == 0)
			{
				this.loadGraphic(Assets.Test2Img);
				current = 1;
				return true;
			}
			else if (current == 1)
			{
				this.loadGraphic(Assets.Test3Img);
				current = 2;
				return true;
			}
			else if (current == 2)
			{
				this.loadGraphic(Assets.Test1Img);
				current = 0;
				return true;
			}
			
			return false;
		}
		
	}

}