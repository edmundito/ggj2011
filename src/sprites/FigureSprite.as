package sprites
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class FigureSprite extends FlxSprite
	{
		static public const NUM_FRAMES:uint = 4;
		static public const ANIM_FPS:uint = 5;
		
		private var _buildSteps:uint;
		public var _currentStep:uint = 0;
		public var _currentAnim:String;
		private var _didStep:Boolean = false;
		private var _didStepDelta:int = 1;
		public var _scoreText:FlxText;
		private var _TextYPos:uint = 10;
		
		private var _birthFrames:uint;
		private var _idleFrames:uint;
		private var _meltFrames:uint;
		
		public var _graphic:Class;
		
		public function get isDone():Boolean
		{
			return _currentStep >= _buildSteps;
		}
		
		public function FigureSprite(X:Number, Y:Number, Graphic:Class, buildSteps:uint)
		{
			super(X, Y);
			
			_graphic = Graphic;
			
			if (_graphic == Assets.Figure9BlueGraphic || _graphic == Assets.Figure9RedGraphic)
			{
				loadGraphic(Graphic, true, false, 108, 100);
				this.width = 108;
				this.height = 100;
			}
			else
			{
				loadGraphic(Graphic, true, false, 80, 80);
				this.width = 80;
				this.height = 80;
			}
			
			this.offset.x = this.width * 0.5;
			this.offset.y = this.height;
			
			_buildSteps = buildSteps;
			
			// Score Text
			_scoreText = new FlxText(this.x, this.y + _TextYPos, 30);
			_scoreText.visible = true;
			_scoreText.color = 0xff000000;
			
			// Frames
			_birthFrames = 4;
			_meltFrames = 1;
			
			addAnimation("birth0", [0]);
			addAnimation("birth1", [1]);
			addAnimation("birth2", [2]);
			addAnimation("birth3", [3]);
			
			if (_graphic == Assets.Figure1BlueGraphic || _graphic == Assets.Figure1RedGraphic)
			{
				_idleFrames = 2;
				addAnimation("idle", [4,5], ANIM_FPS, true);
			}
			else if (_graphic == Assets.Figure2BlueGraphic || _graphic == Assets.Figure2RedGraphic ||
					_graphic == Assets.Figure4BlueGraphic || _graphic == Assets.Figure4RedGraphic )
			{
				_idleFrames = 4;
				addAnimation("idle", [4,5,6,7], ANIM_FPS, true);
			}
			else if (_graphic == Assets.Figure3BlueGraphic || _graphic == Assets.Figure3RedGraphic ||
					_graphic == Assets.Figure5BlueGraphic || _graphic == Assets.Figure5RedGraphic ||
					_graphic == Assets.Figure6BlueGraphic || _graphic == Assets.Figure6RedGraphic ||
					_graphic == Assets.Figure7BlueGraphic || _graphic == Assets.Figure7RedGraphic ||
					_graphic == Assets.Figure8BlueGraphic || _graphic == Assets.Figure8RedGraphic ||
					_graphic == Assets.Figure9BlueGraphic || _graphic == Assets.Figure9RedGraphic ||
					_graphic == Assets.Figure10BlueGraphic || _graphic == Assets.Figure10RedGraphic)
			{
				_idleFrames = 3;
				addAnimation("idle", [4,5,6], ANIM_FPS, true);
			}
			
			addAnimation("melt", [_birthFrames + _idleFrames], 1, true);
		}
		
		public function buildStep():void
		{
			if (!this.isDone)
			{
				_currentStep++;
				_didStep = true;
				_currentAnim = "birth" + (Math.floor((_currentStep / _buildSteps) * (NUM_FRAMES - 1)) as int);
			}
		}
		
		override public function update():void
		{
			play(_currentAnim);

			if (_didStep)
			{
				 this.x += _didStepDelta;
				 _didStepDelta *= -1;
				 _didStep = false;
			}
			
			super.update();
		}
		
		public function melt():void
		{
			_currentAnim = "melt";
		}
		
	}
}