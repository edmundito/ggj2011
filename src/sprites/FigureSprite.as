package sprites
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class FigureSprite extends FlxSprite
	{
		public const NUM_FRAMES:uint = 4;
		
		private var _buildSteps:uint;
		private var _currentStep:uint = 0;
		public var _currentAnim:String;
		private var _didStep:Boolean = false;
		private var _didStepDelta:int = 1;
		
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
			loadGraphic(Graphic, true, false, 80, 80);
			this.width = 80;
			this.height = 80;
			
			this.offset.x = this.width * 0.5;
			this.offset.y = this.height;
			
			_buildSteps = buildSteps;
			
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
				addAnimation("idle", [4,5], 4, true);
			}
			else if (_graphic == Assets.Figure2BlueGraphic || _graphic == Assets.Figure2RedGraphic ||
					_graphic == Assets.Figure4BlueGraphic || _graphic == Assets.Figure4RedGraphic )
			{
				_idleFrames = 4;
				addAnimation("idle", [4,5,6,7], 4, true);
			}
			else if (_graphic == Assets.Figure3BlueGraphic || _graphic == Assets.Figure3RedGraphic ||
					_graphic == Assets.Figure5BlueGraphic || _graphic == Assets.Figure5RedGraphic )
			{
				_idleFrames = 3;
				addAnimation("idle", [4,5,6], 4, true);
			}
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
		
	}
}