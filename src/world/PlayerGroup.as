package world 
{	
	import org.flixel.*;
	
	import sprites.FigureSprite;
	import sprites.PlayerSprite;
	
	import world.Background;
	import world.FigureGroup;
	
	public class PlayerGroup extends FlxGroup 
	{
		static public const TRANSITIONBUFFER:Number = 20;
		
		private var _background:Background;
		private var _backgroundFront:Background;
		private var _player:PlayerSprite;
		private var _figureGroup:FigureGroup;
		private var _emitterGroup:FlxGroup;
		private var _keyText:FlxText;
		private var _keySprite:FlxSprite;
		private var _buildKey:String = "";
		private var _buildCount:uint = 0;
		private var _buildTimes:Array = [];
		private var _overlappingFigure:FigureSprite;
		private var _completedFigures:Array = [];
		private var _scoring:Boolean = false;
		
		public function get buildCount():uint
		{
			return _buildCount;
		}
		
		public function PlayerGroup(player:PlayerSprite) 
		{
			super();
			
			// Background
			_background = new Background(Assets.BgGraphic);
			add(_background);
			_background.next();
			
			_emitterGroup = new FlxGroup();
			add(_emitterGroup);
			
			_figureGroup = new FigureGroup(player.colorKey);
			add(_figureGroup);
			
			_keySprite = new FlxSprite();
			_keySprite.loadGraphic(Assets.KeyGraphic, true, true, 32, 32);
			_keySprite.addAnimation("idle", [0, 1], 4, true);
			_keySprite.visible = false;
			_keySprite.play("idle");
			add(_keySprite);
			
			_keyText = new FlxText(0, 0, 20, "");
			_keyText.visible = false;
			add(_keyText);
			
			_player = player;
			add(_player);
			
			// Ground
			_backgroundFront = new Background(Assets.BgFrontGraphic, 16);
			_backgroundFront.next();
			_backgroundFront.offset.x = 0;
			_backgroundFront.offset.y = _backgroundFront.height;
			_backgroundFront.x = 0;
			_backgroundFront.y = FlxG.height * 0.5;
			add(_backgroundFront);
		}
		
		override public function update():void
		{
			
			var isNearFigure:Boolean = false;
			
			// No update if score
			if (_scoring)
			{
				super.update();
				return;
			}
			
			// Update Player
			for each (var figure:FigureSprite in _figureGroup.members)
			{
				// Player is colliding with figure that has not been built!
				if (_player.overlapsPoint(figure.x, figure.y - figure.height * 0.5) && !figure.isDone)
				{
					if (_overlappingFigure != figure)
					{
						if (_buildKey != "")
						{
							Globals.randomKeyMgr.releaseKey(_buildKey);
							_buildKey = "";
						}
						_overlappingFigure = figure;
					}
					
					if (_buildKey == "")
					{
						_buildKey = Globals.randomKeyMgr.getFreeKey();
						_keyText.text = _buildKey;
						
						// Show key hint...
						_keyText.visible = true;
						_keyText.x = figure.x + 10;
						_keyText.y = figure.y - figure.height - 3;
						
						_keySprite.visible = true;
						_keySprite.x = figure.x;
						_keySprite.y = figure.y - figure.height - 10;
					}
					
					
					
					isNearFigure = true;
					
					// Player pressing key...
					if (FlxG.keys.justPressed(_buildKey))
					{
						if (_player.state != PlayerSprite.STATE_BUILD)
						{
							_player.state = PlayerSprite.STATE_BUILD;
							_buildTimes.push(0.0);
						}
						else
						{
							_buildTimes[_buildTimes.length - 1] += FlxG.elapsed;
						}
						
						figure.buildStep();
						_player.building();
						
						// Figure finally complete...
						if (figure.isDone)
						{
							_buildCount++;
							
							isNearFigure = false;
							_player.state = PlayerSprite.STATE_RUN;
							Globals.randomKeyMgr.releaseKey(_buildKey);
							_buildKey = "";
							
							_keyText.visible = false;
							_keySprite.visible = false;
							addEmitter(figure.x , figure.y - 20);
							FlxG.play(Assets.BuiltSound);
							_overlappingFigure = null;
							figure._currentAnim = "idle";
							
							_completedFigures.push(figure._graphic);
						}
					}
					
					break;
				}
			}
			
			// No longer near figure and key hint is showing
			if (!isNearFigure && _overlappingFigure)
			{
				_keyText.visible = false;
				_keySprite.visible = false;
				Globals.randomKeyMgr.releaseKey(_buildKey);
				_buildKey = "";
				_overlappingFigure = null;
			}
			
			// Next Background if needed
			if (_player.x > FlxG.width - TRANSITIONBUFFER)
			{
				if (_background.next())
				{
					_backgroundFront.next();
					_player.x = TRANSITIONBUFFER;
					_figureGroup.next();
					
					for each (var emitter:FlxEmitter in _emitterGroup.members)
					{
						emitter.kill();
					}
					_emitterGroup.members.splice(0, _emitterGroup.members.length);
				}
				else
				{
					_player.x = FlxG.width - TRANSITIONBUFFER;
				}
			}
			
			super.update();
		}
		
		private function addEmitter(x:Number, y:Number):void
		{
			var emitter:FlxEmitter = new FlxEmitter(x, y);
			emitter.setXSpeed( -15, 15);
			emitter.setYSpeed( -70, -90);
			emitter.gravity = 80;
			
			for(var i:int = 0; i < 15; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(2, 2, 0xffffffff);
				emitter.add(particle);
			}
			
			emitter.start();
			_emitterGroup.add(emitter);
		}

		public function goToScore():void
		{
			_scoring = true;
			_player.state = PlayerSprite.STATE_SCORING;
			_player.play("idle");
			_figureGroup.score(_completedFigures);
			_player.x = FlxG.width / 2;
			_keyText.visible = false;
			_keySprite.visible = false;
		}
		
		public function nextSeason():void
		{
			_background.nextSeason();
			_backgroundFront.nextSeason();
		}
	}

}