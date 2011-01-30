package world 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	import sprites.FigureSprite;
	
	public class FigureGroup extends FlxGroup 
	{
		static public const FIGUREOFFSET:int = 82;
		
		private var _current:uint = 0;
		
		public function FigureGroup() 
		{
			super();
			
			// yes?
			next();
		}
		
		public function next():void
		{
			// Clean out current figures
			this.destroyMembers();
			
			if (_current == 1)
			{
				add(new FigureSprite(FlxG.width * 0.5, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
			}
			else if (_current == 2)
			{
				add(new FigureSprite(FlxG.width / 3, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
				add(new FigureSprite(FlxG.width / 3 * 2, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
			}
			else if (_current == 3)
			{	
				add(new FigureSprite(FlxG.width / 4, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
				add(new FigureSprite(FlxG.width / 4 * 2, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
				add(new FigureSprite(FlxG.width / 4 * 3, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
				
				_current = 1;
			}
			
			_current++;
			
		}
	}

}