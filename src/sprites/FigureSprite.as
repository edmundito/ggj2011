package sprites
{
	import org.flixel.FlxSprite;
	
	public class FigureSprite extends FlxSprite
	{
		public const NUM_FRAMES:uint = 4;
		
		private var _buildSteps:uint;
		private var _currentStep:uint = 0;
		
		public function get isDone():Boolean
		{
			return _currentStep >= _buildSteps;
		}
		
		public function FigureSprite(X:Number, Y:Number, Graphic:Class, buildSteps:uint)
		{
			super(X, Y);
			
			loadGraphic(Graphic, true, false, 64, 64);
			this.width = 64;
			this.height = 64;
			
			this.offset.x = this.width * 0.5;
			this.offset.y = this.height;
			
			_buildSteps = buildSteps;
			
			addAnimation("build0", [0]);
			addAnimation("build1", [1]);
			addAnimation("build2", [2]);
			addAnimation("build3", [3]);
		}
		
		public function buildStep():void
		{
			if (!this.isDone)
			{
				_currentStep++;
			}
		}
		
		override public function update():void
		{
			play("build" + (Math.floor(_currentStep / _buildSteps * NUM_FRAMES) as int));
		}
	}
}