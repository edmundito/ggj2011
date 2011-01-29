package sprites
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class PlayerSprite extends FlxSprite
	{
		public const MOVE_SPEED:int = 70;
		public const WALK_FPS:int = 4;
		
		private var _animTime:Number;
		
		private var _moveKeyA:String;
		private var _moveKeyB:String;
		private var _moveDirection:int;
		
		[Embed(source="../../assets/sprites/snowman.png")]
		static protected var SnowmanImg:Class;
		
		public function PlayerSprite(MoveKeyA:String, MoveKeyB:String, Facing:uint, X:Number=0, Y:Number=0)
		{
			super(X, Y);
			
			_moveKeyA = MoveKeyA;
			_moveKeyB = MoveKeyB;
			
			
			loadGraphic(SnowmanImg, true, true, 51, 64);
			this.width = 51;
			this.height = 64;
			
			this.offset.x = this.width * 0.5;
			this.offset.y = this.height;
			
			addAnimation("idle", [0]);
			addAnimation("walking", [1, 2, 0], WALK_FPS, true);
			
			addAnimation("walk0", [0], WALK_FPS, true);
			addAnimation("walk1", [1], WALK_FPS, true);
			addAnimation("walk2", [2], WALK_FPS, true);
			
			this.facing = Facing;
			if (this.facing == RIGHT)
			{
				_moveDirection = 1;
			}
			else
			{
				_moveDirection = -1;
			}
			
			
			this.maxVelocity.x = MOVE_SPEED;
			this.maxVelocity.y = MOVE_SPEED;
			this.drag.x = MOVE_SPEED * 8;
			this.drag.y = MOVE_SPEED * 8;
		}
		
		override public function update():void
		{
			// Update Movement
			updateTwoKeys();
			
			super.update();
		}
		
		private function updateSmooth():void
		{
			// Update Movement
			
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			if (FlxG.keys.LEFT)
			{
				this.facing = RIGHT;
				this.acceleration.x -= this.drag.x;
			}
			
			if (FlxG.keys.RIGHT)
			{
				this.facing = LEFT;
				this.acceleration.x += this.drag.x;
			}
			
			// Update Animation
			
			if (this.acceleration.x != 0)
			{
				play("walking");	
			}
			else
			{
				play("idle");
			}
		}
		
		private function updateAntiGlide():void
		{
			var delta:int = 0;
			
			if (FlxG.keys.LEFT)
			{
				this.facing = RIGHT;
				delta -= 1;
			}
			
			if (FlxG.keys.RIGHT)
			{
				this.facing = LEFT;
				delta += 1;
			}
			
			if (FlxG.keys.RIGHT || FlxG.keys.LEFT)
			{
				_animTime += FlxG.elapsed;
				play("walking");
			}
			else
			{
				_animTime = 0;
				play("idle");
			}
			
			if (_animTime > 1 / WALK_FPS)
			{
				this.x += delta * MOVE_SPEED / WALK_FPS;
				_animTime -= 1 / WALK_FPS;
			}
		}
		
		private var _isAltKey:Boolean = false;
		private var _currentAnimFrame:uint = 0;
		public const MAX_WALK_ANIM_FRAMES:uint = 3;
		
		private function moveForward():void
		{
			this.x += _moveDirection * 10;
			_isAltKey = !_isAltKey;
			_currentAnimFrame++;
			
			if (_currentAnimFrame > MAX_WALK_ANIM_FRAMES)
			{
				_currentAnimFrame = 0;
			}
			
		}
		
		private function updateTwoKeys():void
		{
			if (FlxG.keys.justPressed(_moveKeyA) && !_isAltKey)
			{
				moveForward();
			}
			else if (FlxG.keys.justPressed(_moveKeyB) && _isAltKey)
			{
				moveForward();
			}
			
			play("walk" + _currentAnimFrame);
		}
	}
}