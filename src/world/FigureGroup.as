package world 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	
	import sprites.FigureSprite;
	
	public class FigureGroup extends FlxGroup 
	{
		static private const FIGUREOFFSET:int = 114;
		static private const NUM_FIGURES:uint = 8;
		static private const BUILD_INC:uint = 8;
		
		public static const FIGURE_GRAPHICS:Object = {
			"blue": [
				Assets.Figure1BlueGraphic,
				Assets.Figure2BlueGraphic,
				Assets.Figure3BlueGraphic,
				Assets.Figure4BlueGraphic,
				Assets.Figure5BlueGraphic,
				Assets.Figure6BlueGraphic,
				Assets.Figure7BlueGraphic,
				Assets.Figure8BlueGraphic
			],
			"red": [
				Assets.Figure1RedGraphic,
				Assets.Figure2RedGraphic,
				Assets.Figure3RedGraphic,
				Assets.Figure4RedGraphic,
				Assets.Figure5RedGraphic,
				Assets.Figure6RedGraphic,
				Assets.Figure7RedGraphic,
				Assets.Figure8RedGraphic
			]
		}
		
		private var _current:uint = 0;
		private var _figureGraphics:Array;
		private var _buildSteps:uint = 8;
		private var _figureIndex:uint = 3;
		
		public function FigureGroup(colorKey:String) 
		{
			super();
			
			_figureGraphics = FIGURE_GRAPHICS[colorKey];
			
			// yes?
			next();
		}
		
		private function nextFigureIndex():void
		{
			_figureIndex++;
			
			if (_figureIndex >= NUM_FIGURES)
			{
				_figureIndex = 0;
			}
		}
		
		public function next():void
		{
			// Clean out current figures
			this.destroyMembers();
			
			FlxG.log("" + _current);
			
			if (_current == 1)
			{
				add(new FigureSprite(FlxG.width * 0.5, this.y + FIGUREOFFSET, _figureGraphics[1], _buildSteps));
			}
			else if (_current == 2)
			{
				add(new FigureSprite(FlxG.width / 3, this.y + FIGUREOFFSET, _figureGraphics[0], _buildSteps));
				add(new FigureSprite(FlxG.width / 3 * 2, this.y + FIGUREOFFSET, _figureGraphics[2], _buildSteps));
			}
			else if (_current >= 3)
			{	
				add(new FigureSprite(FlxG.width / 4, this.y + FIGUREOFFSET, _figureGraphics[_figureIndex], _buildSteps));
				nextFigureIndex();
				add(new FigureSprite(FlxG.width / 4 * 2, this.y + FIGUREOFFSET, _figureGraphics[_figureIndex], _buildSteps));
				nextFigureIndex();
				add(new FigureSprite(FlxG.width / 4 * 3, this.y + FIGUREOFFSET, _figureGraphics[_figureIndex], _buildSteps));
				nextFigureIndex();
				
				if (_buildSteps == BUILD_INC)
				{
					_buildSteps += BUILD_INC;
				}
				
				_current = 1;
			}
			
			_current++;
		}
		
		public function score(figures:Array):void
		{
			this.destroyMembers();
			
			var index:uint = 1;
			for each (var figureGraphic:Class in figures)
			{
				var sprite:FigureSprite;
				
				// Figure out X
				var x:uint;
				var half:uint = FlxG.width/2;
				
				if (index % 2)
				{
					x = half + FlxG.width / figures.length * index / 2;
				}
				else
				{
					x = half - FlxG.width / figures.length * index / 2;
				}
				
				sprite = new FigureSprite(x, this.y + FIGUREOFFSET, figureGraphic, 16);
				sprite._currentStep = 100;
				sprite._currentAnim = "idle";
				add(sprite);
				
				index++;
			}
		}
	}

}