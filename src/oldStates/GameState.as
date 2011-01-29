package states 
{
	import flash.utils.getDefinitionByName;
	import org.flixel.*;
	
	import sprites.*;
	import world.*;
	
	public class GameState extends FlxState 
	{
		static public const FLASHFADETIME:Number = 0.5;
		static public const TRANSITIONBUFFER:Number = 15;
		static public const SAFEBUFFER:Number = 25;
		static public const GROUND:Number = 200;
		
		static public var _worldTimer:TurnBasedTimer = new TurnBasedTimer();
		static public var _prevState:GameState = null;
		
		protected var _player:PlayerSprite;
		protected var _leftScene:Class;
		protected var _rightScene:Class;
		private var _newState:GameState;
		
		override public function create():void
		{	
			_player = null;
			_leftScene = null;
			_rightScene = null;
			_newState = null;
		}
		
		override public function update():void
		{
			super.update();
			
			var sceneClass:Class
			
			if (_leftScene == null)
			{
				if (_player.x < SAFEBUFFER) _player.x = SAFEBUFFER;
			}
			else
			{
				if (_player.x < TRANSITIONBUFFER) 
				{
					transitionLeft(new _leftScene() as GameState);
				}
			}
			
			if (_rightScene == null)
			{
				if (_player.x > FlxG.width - SAFEBUFFER) _player.x = FlxG.width - SAFEBUFFER;
			}
			else
			{
				if (_player.x > FlxG.width - TRANSITIONBUFFER) 
				{
					transitionLeft(new _rightScene() as GameState);
				}
			}
		}
		
		public function addPlayer(x:Number, y:Number):void
		{
			_player = new PlayerSprite(x, y);
			add(_player);
		}
		
		protected function transitionLeft(newState:GameState):void
		{
			_newState = newState;
			FlxG.fade.start(0xffffffff, FLASHFADETIME, onTransitionFadeDone);
		}
		
		protected function transitionRight(newState:GameState):void
		{
			_newState = newState;
			FlxG.fade.start(0xffffffff, FLASHFADETIME, onTransitionFadeDone);
		}
		
		private function onTransitionFadeDone():void
		{
			_prevState = this;
			_worldTimer._turn++;
			FlxG.state = _newState;
		}
		
	}

}