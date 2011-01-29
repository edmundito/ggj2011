package states 
{
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
		static public var _prevState:GameState;
		
		protected var _player:PlayerSprite;
		private var _newState:GameState;
		
		override public function create():void
		{
		}
		
		override public function update():void
		{
			super.update();
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