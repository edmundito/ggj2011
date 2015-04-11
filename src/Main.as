package 
{
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;

	import org.flixel.*;
	
	import states.*;

	[SWF(width="640", height="480", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{				
		public const ZOOM:uint = 2;
		
		public function Main():void 
		{
			// These are here to make sure that they don't get removed by the compiler.
			Assets;
			Globals;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			super(Globals.getGameWidth(), Globals.getGameHeight(), MainMenuState, ZOOM);
			
			this.useDefaultHotKeys = false;
		}
			
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.fullScreenSourceRect = new Rectangle(0, 0, FlxG.width * ZOOM, FlxG.height * ZOOM);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function onKeyDown(keyboardEvent:KeyboardEvent):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			if (keyboardEvent.altKey && keyboardEvent.keyCode == 13)
			{
				toggleFullScreen();
			}
			
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp1);
		}
		
		private function onKeyUp1(keyboardEvent:KeyboardEvent):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp1);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function toggleFullScreen():void
		{
			stage.displayState = stage.displayState == StageDisplayState.NORMAL? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL;
		}
	}
}
