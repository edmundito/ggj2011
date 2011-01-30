package world 
{
	import org.flixel.*;
	
	import sprites.PlayerSprite;
	
	public class PlayerGroup extends FlxGroup 
	{
		private var _player:PlayerSprite;
		private var _ground:FlxGroup;
		
		[Embed(source="../../assets/sprites/ground.png")]
		static protected var GroundImg:Class;
		
		public function PlayerGroup(player:PlayerSprite) 
		{
			super();
			
			// Ground
			_ground = new FlxGroup();
			add(_ground);
			
			var sprite:FlxSprite;
			
			for (var i:int = 0; i < 8; i++)
			{
				sprite = new FlxSprite();
				sprite.loadGraphic(GroundImg);
				sprite.offset.x = sprite.width * 0.5;
				sprite.offset.y = sprite.height * 0.5;
				sprite.x = sprite.width * i;
				sprite.y = 50;
				_ground.add(sprite);
			}
		
			_player = player;
			add(_player);
		}
		
	}

}