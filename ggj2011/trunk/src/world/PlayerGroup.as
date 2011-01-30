package world 
{	
	import org.flixel.*;
	
	import sprites.FigureSprite;
	import sprites.PlayerSprite;
	
	import world.Background;
	
	public class PlayerGroup extends FlxGroup 
	{
		static public const TRANSITIONBUFFER:Number = 20;
		
		private var _background:Background;
		private var _player:PlayerSprite;
		private var _figure:FigureSprite;
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
		
			// Figures are created before player :)
			_figure = new FigureSprite(FlxG.width * 0.5, _player.y - 5, Assets.BluePlayerGraphic, 16);
			add(_figure);
			
			
			add(_player);
		}
		
		override public function update():void
		{
			if (_player.overlaps(_figure) && _player.state == PlayerSprite.STATE_RUN && !_figure.isDone)
			{
				_player.state = PlayerSprite.STATE_BUILD;	
			}
			
			// Update Player
			if (_player.state == PlayerSprite.STATE_BUILD && FlxG.keys.justPressed("B") && !_figure.isDone)
			{
				_figure.buildStep();
				_player.building();
				
				if (_figure.isDone)
				{
					_player.state = PlayerSprite.STATE_RUN;
				}
			}
			
			// Update Background
			
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
			
			super.update();
		}
		
	}

}