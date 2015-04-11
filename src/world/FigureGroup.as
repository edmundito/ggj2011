package world 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	
	import sprites.FigureSprite;
	
	public class FigureGroup extends FlxGroup 
	{
		static private const FIGURE_OFFSET:int = 114;
		static private const NUM_FIGURES:uint = 10;
		static private const BUILD_INC:uint = 8;
		static public const MELT_TIME:Number = 1.25;
		
		public static const FIGURE_GRAPHICS:Object = {
			"blue": [
				Assets.Figure1BlueGraphic,
				Assets.Figure2BlueGraphic,
				Assets.Figure3BlueGraphic,
				Assets.Figure4BlueGraphic,
				Assets.Figure5BlueGraphic,
				Assets.Figure6BlueGraphic,
				Assets.Figure7BlueGraphic,
				Assets.Figure8BlueGraphic,
				Assets.Figure9BlueGraphic,
				Assets.Figure10BlueGraphic
			],
			"red": [
				Assets.Figure1RedGraphic,
				Assets.Figure2RedGraphic,
				Assets.Figure3RedGraphic,
				Assets.Figure4RedGraphic,
				Assets.Figure5RedGraphic,
				Assets.Figure6RedGraphic,
				Assets.Figure7RedGraphic,
				Assets.Figure8RedGraphic,
				Assets.Figure9RedGraphic,
				Assets.Figure10RedGraphic
			]
		}
		
		private var _current:uint = 0;
		private var _figureGraphics:Array;
		private var _figuresToMelt:Array = [];
		private var _scoresText:Array = [];
		private var _meltTimer:Number = 0;
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
				add(new FigureSprite(FlxG.width * 0.5, this.y + FIGURE_OFFSET, _figureGraphics[1], _buildSteps));
			}
			else if (_current == 2)
			{
				if (_buildSteps == BUILD_INC)
				{
					add(new FigureSprite(FlxG.width / 3, this.y + FIGURE_OFFSET, _figureGraphics[0], _buildSteps));
					add(new FigureSprite(FlxG.width / 3 * 2, this.y + FIGURE_OFFSET, _figureGraphics[2], _buildSteps));
				}
				else
				{
					add(new FigureSprite(FlxG.width / 3, this.y + FIGURE_OFFSET, _figureGraphics[_figureIndex], _buildSteps));
					nextFigureIndex();
					add(new FigureSprite(FlxG.width / 3 * 2, this.y + FIGURE_OFFSET, _figureGraphics[_figureIndex], _buildSteps));
					nextFigureIndex();
				}
			}
			else if (_current >= 3)
			{	
				add(new FigureSprite(FlxG.width / 4, this.y + FIGURE_OFFSET, _figureGraphics[_figureIndex], _buildSteps));
				nextFigureIndex();
				add(new FigureSprite(FlxG.width / 4 * 2, this.y + FIGURE_OFFSET, _figureGraphics[_figureIndex], _buildSteps));
				nextFigureIndex();
				add(new FigureSprite(FlxG.width / 4 * 3, this.y + FIGURE_OFFSET, _figureGraphics[_figureIndex], _buildSteps));
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
					x = half + (FlxG.width * 0.9) / figures.length * index / 2;
				}
				else
				{
					x = half - (FlxG.width * 0.9) / figures.length * index / 2;
				}
				
				sprite = new FigureSprite(x, this.y + FIGURE_OFFSET, figureGraphic, 16);
				sprite._currentStep = 100;
				sprite._currentAnim = "idle";
				add(sprite);
				
				_figuresToMelt.push(sprite);
				
				index++;
			}
		}
		
		public function melt(score:uint):void
		{
			_meltTimer -= FlxG.elapsed;
			
			if (_meltTimer <= 0)
			{
				if (_figuresToMelt.length == 0)
				{
					return;
				}
				
				var figure:FigureSprite = _figuresToMelt.pop();
				figure.melt();
				
				var text:FlxText = new FlxText(figure.x - 12, this.y + 80, 80, score.toString());
				text.visible = true;
				text.color = 0xff000000;
				add(text);
				_scoresText.push(text);

				text = new FlxText(figure.x - 13, this.y + 79, 80, score.toString());
				text.visible = true;
				text.color = 0xffffffff;
				add(text);
				_scoresText.push(text);
				
				_meltTimer = MELT_TIME;
				
				FlxG.play(Assets.PointDeathSound, 0.6);
			}
		}
		
		override public function update():void
		{
			for each (var score:FlxText in _scoresText)
			{
				if (score.y > this.y + 40)
				{
					score.y -= FlxG.elapsed * 20;
				}
				else
				{
					score.visible = false;
				}
			}
			
			super.update();
		}

		public function get isDoneMelting():Boolean
		{
			return _figuresToMelt.length == 0;
		}
	}

}