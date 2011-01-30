package sprites
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class PlayerSprite extends FlxSprite
	{
		static public const STATE_BIRTH:uint = 0;
		static public const STATE_RUN:uint = 1;
		static public const STATE_BUILD:uint = 2;
		
		private const MOVE_SPEED:int = 70;
		private const WALK_FPS:int = 4;
		
		private var _animTime:Number;
		
		private var _moveKeyA:String;
		private var _moveKeyB:String;
		private var _moveDirection:int;
		
		private var _alt:Boolean = false;
		private var _currentAnimName:uint = 0;
		private var _currentAnimFrame:uint = 0;
		static private const MAX_BIRTH_ANIM_FRAMES:uint = 10;
		static private const MAX_WALK_ANIM_FRAMES:uint = 2;
		static private const MAX_BUILD_ANIM_FRAMES:uint = 2;
		
		private var _state:uint = 1;
		private var _colorKey:String;
		
		public function set state(value:uint):void
		{
			if (_state == value)
			{
				return;
			}
			
			_state = value;
			_currentAnimFrame = 0;
			_alt = !_alt;
		}
		
		public function get state():uint
		{
			return _state;
		}
		
		public function get colorKey():String
		{
			return _colorKey;
		}
		
		public function PlayerSprite(ColorKey:String, MoveKeyA:String, MoveKeyB:String, Facing:uint, X:Number=0, Y:Number=0)
		{
			super(X, Y);
			
			_colorKey = ColorKey;
			_moveKeyA = MoveKeyA;
			_moveKeyB = MoveKeyB;
			Globals.randomKeyMgr.addKeyToIgnoreList(_moveKeyA);
			Globals.randomKeyMgr.addKeyToIgnoreList(_moveKeyB);
			
			
			var GraphicClass:Class = (ColorKey == "red")? Assets.RedPlayerGraphic : Assets.BluePlayerGraphic;
			
			loadGraphic(GraphicClass, true, true, 80, 80);
			this.width = 80;
			this.height = 80;
			
			this.offset.x = this.width * 0.5;
			this.offset.y = this.height;
			
			//addAnimation("idle", [0]);
			//addAnimation("walking", [1, 2, 0], WALK_FPS, true);
			
			addAnimation("walk0", [9], WALK_FPS, true);
			addAnimation("walk1", [8], WALK_FPS, true);
			
			addAnimation("build0", [10], WALK_FPS, true);
			addAnimation("build1", [11], WALK_FPS, true);
			
			addAnimation("birth0", [0]);
			addAnimation("birth1", [1]);
			addAnimation("birth2", [2]);
			addAnimation("birth3", [1]);
			addAnimation("birth4", [2]);
			addAnimation("birth5", [1]);
			addAnimation("birth6", [2]);
			addAnimation("birth7", [5]);
			addAnimation("birth8", [2]);
			addAnimation("birth9", [3]);
			
			
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
			
			this.state = PlayerSprite.STATE_BIRTH;
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
		
		private function moveForward():void
		{
			if (_state == STATE_RUN)
			{
				this.x += _moveDirection * 10;
			}
			
			_alt = !_alt;
			_currentAnimFrame++;
			
			if ((_state == STATE_RUN && _currentAnimFrame >= MAX_WALK_ANIM_FRAMES) ||
				(_state == STATE_BIRTH && _currentAnimFrame >= MAX_BIRTH_ANIM_FRAMES))
			{
				_currentAnimFrame = 0;
				
				// Finished birth state? run lola run!
				if (_state == STATE_BIRTH)
				{
					this.state = STATE_RUN;
				}
			}
			
		}
		
		private var _ready:Boolean = false;
		
		private function updateTwoKeys():void
		{
			if (_state != STATE_BUILD)
			{
				if ((FlxG.keys.justReleased(_moveKeyA) && !_alt) ||
					(FlxG.keys.justReleased(_moveKeyB) && _alt))
				{
					_ready = true;
				}
				
				if (FlxG.keys.justPressed(_moveKeyA) && _alt)
				{
					moveForward();
					_ready = false;
				}
				else if (FlxG.keys.justPressed(_moveKeyB) && !_alt)
				{
					moveForward();
					_ready = false;
				}
			}
			
			if (_state == STATE_BUILD)
			{
				play("build" + _currentAnimFrame);
			}
			else if (_state == STATE_BIRTH)
			{
				play("birth" + _currentAnimFrame);
			}
			else
			{
				play("walk" + _currentAnimFrame);
			}
		}
		
		public function building():void
		{
			_currentAnimFrame++;
			
			if (_currentAnimFrame >= MAX_BUILD_ANIM_FRAMES)
			{
				_currentAnimFrame = 0;
			}
		}
	}
}