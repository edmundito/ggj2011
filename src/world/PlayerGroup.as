package world 
{
	import org.flixel.*;
	
	import Assets;
	import sprites.PlayerSprite;
	import world.Background;
	
	public class PlayerGroup extends FlxGroup 
	{
		static public const TRANSITIONBUFFER:Number = 20;
		
		private var _background:Background;
		private var _player:PlayerSprite;
		private var _ground:FlxGroup;
		
		public function PlayerGroup(player:PlayerSprite) 
		{
			super();
			
			// Background
			_background = new Background();
			_background.loadGraphic(Assets.Test1Img);
			add(_background);
			
			// Ground
			_ground = new FlxGroup();
			add(_ground);
			
			var sprite:FlxSprite;
			
			for (var i:int = 0; i < 8; i++)
			{
				sprite = new FlxSprite();
				sprite.loadGraphic(Assets.GroundImg);
				sprite.offset.x = sprite.width * 0.5;
				sprite.offset.y = sprite.height * 0.5;
				sprite.x = sprite.width * i;
				sprite.y = 90;
				_ground.add(sprite);
			}
		
			_player = player;
			add(_player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (_player.x > FlxG.width - TRANSITIONBUFFER)
			{
				if (_background.next())
				{
					_player.x = TRANSITIONBUFFER;
				}
				else
				{
					_player.x = FlxG.width - TRANSITIONBUFFER;
				}
			}
		}
		
	}

}