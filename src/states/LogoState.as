package states 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	
	public class LogoState extends FlxState
	{
		
		override public function create():void 
		{
			var logo:FlxSprite = new FlxSprite(0, 0, Assets.LogoGraphic);
			logo.scale = new FlxPoint(0.75, 0.75);
			add(logo);
			
			super.create();
			
			FlxG.flash.start(0xff000000, 2.0, onFlashDone1);
		}
		
		private function onFlashDone1():void
		{
			FlxG.flash.start(0x00000000, 3.0, onFlashDone2);
		}
		
		private function onFlashDone2():void
		{
			FlxG.fade.start(0xff0000000, 2.0, onFadeDone);
		}
		
		private function onFadeDone():void
		{
			FlxG.state = new MainMenuState();
		}
	}

}