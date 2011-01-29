package sprites
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class PlayerSprite extends FlxSprite
	{
		public const MOVE_SPEED:int = 100;
		
		[Embed(source="../../assets/sprites/snowman.png")]
		static protected var SnowmanImg:Class;
		
		public function PlayerSprite(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			
			loadGraphic(SnowmanImg, true, false, 51, 64);
			this.width = 51;
			this.height = 64;
			
			addAnimation("idle", [0]);
			addAnimation("walking", [1, 2, 0], 5, true);
			
			this.maxVelocity.x = MOVE_SPEED;
			this.maxVelocity.y = MOVE_SPEED;
			this.drag.x = MOVE_SPEED * 8;
			this.drag.y = MOVE_SPEED * 8;
		}
		
		override public function update():void
		{
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			if (FlxG.keys.LEFT)
			{
				this.acceleration.x -= this.drag.x;
				this.facing = LEFT;
			}
			
			if (FlxG.keys.RIGHT)
			{
				this.acceleration.x += this.drag.x;
				this.facing = RIGHT;
			}
			
			if (this.acceleration.x != 0)
			{
				play("walking");
			}
			else
			{
				play("idle");
			}
			
			/*
			if (FlxG.keys.UP)
			{
				this.acceleration.y -= this.drag.y;
			}
			
			if (FlxG.keys.DOWN)
			{
				this.acceleration.y += this.drag.y;
			}
			*/
		
			
			super.update();
		}
	}
}