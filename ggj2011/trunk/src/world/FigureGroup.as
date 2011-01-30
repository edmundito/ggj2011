package world 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	
	import sprites.FigureSprite;
	
	public class FigureGroup extends FlxGroup 
	{
		static public const FIGUREOFFSET:int = 82;
		
		private var current:int = 0;
		
		public function FigureGroup() 
		{
			// yes?
			next();
		}
		
		public function next():void
		{
			// Clean out current figures
			this.destroyMembers();
			
			if (current == 0)
			{
				this.add(new FigureSprite(FlxG.width * 0.5, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
			}
			else if (current == 1)
			{
				this.add(new FigureSprite(FlxG.width / 3, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
				this.add(new FigureSprite(FlxG.width / 3 * 2, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
			}
			else
			{
				
				this.add(new FigureSprite(FlxG.width / 4, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
				this.add(new FigureSprite(FlxG.width / 4 * 2, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
				this.add(new FigureSprite(FlxG.width / 4 * 3, this.y + FIGUREOFFSET, Assets.BluePlayerGraphic, 16));
			}
			
			current++;
		}
	}

}