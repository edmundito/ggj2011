package world 
{
	import flash.text.TextFormatAlign;

	import org.flixel.*;
	
	import sprites.FigureSprite;
	import sprites.PlayerSprite;
	
	public class PlayerGroup extends FlxGroup 
	{
		static public const TRANSITION_BUFFER:Number = 20;
		
		private var _background:Background;
		private var _backgroundFront:Background;
		private var _player:PlayerSprite;
		private var _figureGroup:FigureGroup;
		private var _emitterGroup:FlxGroup;
		private var _buildKey:String = "";
		private var _buildCount:uint = 0;
		private var _buildTimes:Array = [];
		private var _overlappingFigure:FigureSprite;
		private var _completedFigures:Array = [];
		private var _scoring:Boolean = false;
		private var _sun:FlxSprite;
		private var _sunDone:Boolean = false;
		private var _playerMeltCooldown:Number = 2.0;
		private var _totalScore:uint = 0;
		private var _complete:Boolean = false;
		private var _figureKeyBubble:KeyBubble;
		private var _playerKeyBubble:KeyBubble;
		private var _playerWasBorn:Boolean;
		
		public function PlayerGroup(player:PlayerSprite) 
		{
			super();
			
			// Background
			_background = new Background(Assets.BgGraphic);
			add(_background);
			_background.next();
			
			_figureGroup = new FigureGroup(player.colorKey);
			add(_figureGroup);
			_figureKeyBubble = new KeyBubble(player.colorKey, this, 31, 32);
			
			
			_player = player;
			add(_player);
			
			_playerKeyBubble = new KeyBubble(player.colorKey + "2", this, 55, 32, true);

			_emitterGroup = new FlxGroup();
			add(_emitterGroup);
			
			// Sun in the Front
			_sun = new FlxSprite(330, 0);
			_sun.loadGraphic(Assets.SunGraphic, true, false, 64, 64);
			_sun.addAnimation("idle", [0, 1, 2], 1, true);
			_sun.play("idle");
			add(_sun);
			
			// Ground
			_backgroundFront = new Background(Assets.BgFrontGraphic, 14);
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
			
			// Scoring update
			if (_scoring)
			{
				if (_sun.x > 160)
				{
					_sun.x -= 15.0 * FlxG.elapsed;
					if (_sun.x <= 240)
					{
						_sunDone = true;
					}
				}

				if (_sunDone)
				{
					if (!_figureGroup.isDoneMelting)
					{
						var time:Number = _buildTimes.pop();
						var score:uint = (10.0 - time) * 100;
						//FlxG.log(score.toString());
						if (score <= 0) score = 100;
						_figureGroup.melt(score);
						_totalScore += score;
					}
					else if (!_complete)
					{
						if (_playerMeltCooldown < 0.0)
						{
							if (_playerWasBorn)
							{
								// Melt the player
								_player.play("melt");
								FlxG.play(Assets.PointDeathSound, 0.5);
							}

							var text:String = "TOTAL SCORE: " + _totalScore.toString();
							var totalScoreText:FlxText = new FlxText(0, this.y + 15, Globals.getGameWidth());
							totalScoreText.text = text;
							add(totalScoreText);
							totalScoreText.setFormat(null, 8, 0xff000000, TextFormatAlign.CENTER);

							totalScoreText = new FlxText(-1, this.y + 14, Globals.getGameWidth());
							totalScoreText.text = text;
							add(totalScoreText);
							totalScoreText.setFormat(null, 8, 0xffffffff, TextFormatAlign.CENTER);
							_complete = true;
						}
						
						_playerMeltCooldown -= FlxG.elapsed;
					}
				}
				
				super.update();
				return;
			}
			
			if (_player.state == PlayerSprite.STATE_BIRTH && !_playerKeyBubble.isVisible)
			{
				showPlayerKeyBubble();
			}
			else if (_player.moved())
			{
				_playerKeyBubble.hide();
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
						
						_figureKeyBubble.show(figure.x, figure.y - figure.height, _buildKey);
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
							
							_figureKeyBubble.hide();
							_playerKeyBubble.show(figure.x, figure.y - figure.height, _player.moveKeyA, _player.moveKeyB);
							addEmitter(figure.x , figure.y - (figure.height * 0.4));
							FlxG.play(PlayerSprite.BUILT_SOUNDS[_player.colorKey]);
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
				_figureKeyBubble.hide();
				Globals.randomKeyMgr.releaseKey(_buildKey);
				_buildKey = "";
				_overlappingFigure = null;
			}
			
			// Next Background if needed
			if (_player.x > FlxG.width - TRANSITION_BUFFER)
			{
				if (_background.next())
				{
					_backgroundFront.next();
					_player.x = TRANSITION_BUFFER;
					_figureGroup.next();

					killEmitters();
				}
				else
				{
					_player.x = FlxG.width - TRANSITION_BUFFER;
				}
			}
			
			super.update();
		}
		
		private function addEmitter(x:Number, y:Number):void
		{
			var emitter:FlxEmitter = new FlxEmitter(x, y);
			emitter.setXSpeed( -25, 25);
			emitter.setYSpeed( -70, -110);
			emitter.gravity = 80;
			
			for(var i:int = 0; i < 40; i++)
			{
				var particle:FlxSprite = new FlxSprite();
				particle.createGraphic(2, 2, 0xFFFFFFFF); // 0xffE5FB05);
				emitter.add(particle);
			}
			
			emitter.start();
			_emitterGroup.add(emitter);
		}

		private function killEmitters():void
		{
			for each (var emitter:FlxEmitter in _emitterGroup.members)
			{
				emitter.kill();
			}
			_emitterGroup.members.splice(0, _emitterGroup.members.length);
		}

		public function goToScore():void
		{
			_scoring = true;
			if(_player.hasStartedBirth) {
				_playerWasBorn = true;
			}
			if(_player.state != PlayerSprite.STATE_BIRTH) {
				_player.play("walk0");
				_player.x = FlxG.width / 2;
			}
			_player.state = PlayerSprite.STATE_SCORING;
			_figureGroup.score(_completedFigures);
			_figureKeyBubble.hide();
			_playerKeyBubble.hide();
			killEmitters();
			_background.forceEndOfSeason();
			if (_background.next())
			{
				_backgroundFront.forceEndOfSeason();
				_backgroundFront.next();
			}
		}
		
		public function nextSeason():void
		{
			_background.nextSeason();
			_backgroundFront.nextSeason();
		}

		private function showPlayerKeyBubble():void
		{
			_playerKeyBubble.show(
				_player.x + _player.width * 0.25,
				_player.y - _player.height * (_player.state == PlayerSprite.STATE_BIRTH? 0.75 : 1.0),
				_player.moveKeyA,
				_player.moveKeyB
			);
		}

		public function get complete():Boolean
		{
			return _complete;
		}
	}

}