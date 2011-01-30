package world 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	import sprites.FigureSprite;
	
	public class FigureGroup extends FlxGroup 
	{
		static public const FIGUREOFFSET:int = 114;
		
		public static const FIGURE_GRAPHICS:Object = {
			"blue": [
				Assets.Figure1BlueGraphic,
				Assets.Figure2BlueGraphic,
				Assets.Figure3BlueGraphic,
				Assets.Figure4BlueGraphic,
				Assets.Figure5BlueGraphic
			],
			"red": [
				Assets.Figure1RedGraphic,
				Assets.Figure2RedGraphic,
				Assets.Figure3RedGraphic,
				Assets.Figure4RedGraphic,
				Assets.Figure5RedGraphic
			]
		}
		
		private var _current:uint = 0;
		private var _figureGraphics:Array;
		
		public function FigureGroup(colorKey:String) 
		{
			super();
			
			_figureGraphics = FIGURE_GRAPHICS[colorKey];
			
			// yes?
			next();
		}
		
		public function next():void
		{
			// Clean out current figures
			this.destroyMembers();
			
			if (_current == 1)
			{
				add(new FigureSprite(FlxG.width * 0.5, this.y + FIGUREOFFSET, _figureGraphics[1], 16));
			}
			else if (_current == 2)
			{
				add(new FigureSprite(FlxG.width / 3, this.y + FIGUREOFFSET, _figureGraphics[3], 16));
				add(new FigureSprite(FlxG.width / 3 * 2, this.y + FIGUREOFFSET, _figureGraphics[2], 16));
			}
			else if (_current == 3)
			{	
				add(new FigureSprite(FlxG.width / 4, this.y + FIGUREOFFSET, _figureGraphics[4], 16));
				add(new FigureSprite(FlxG.width / 4 * 2, this.y + FIGUREOFFSET, _figureGraphics[0], 16));
				add(new FigureSprite(FlxG.width / 4 * 3, this.y + FIGUREOFFSET, _figureGraphics[3], 16));
				
				_current = 1;
			}
			
			_current++;
			
		}
	}

}