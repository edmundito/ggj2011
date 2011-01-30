package world
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;

	public class KeyBubble
	{
		public static const KEY_GRAPHICS:Object = {
			"blue" : Assets.BlueKeyGraphic,
			"red" : Assets.RedKeyGraphic,
			"blue2" : Assets.Blue2KeyGraphic,
			"red2" : Assets.Red2KeyGraphic
			};
		
		private var _keySprite:FlxSprite;
		private var _keyText:FlxText;
		private var _keyText2:FlxText;
		
		public function get isVisible():Boolean
		{
			return _keySprite.visible;
		}
		
		public function KeyBubble(colorKey:String, parent:FlxGroup, width:uint, height:uint, twoKeys:Boolean = false)
		{
			_keySprite = new FlxSprite();
			_keySprite.fixed = false;
			_keySprite.loadGraphic(KEY_GRAPHICS[colorKey], true, true, width, height);
			_keySprite.addAnimation("idle", [1, 0], 4, true);
			_keySprite.visible = false;
			_keySprite.play("idle");
			parent.add(_keySprite);
			
			_keyText = new FlxText(0, 0, 20, "");
			_keyText.visible = false;
			_keyText.color = 0xFF000000;
			parent.add(_keyText);
			
			if (twoKeys)
			{
				_keyText2 = new FlxText(0, 0, 20, "");
				_keyText2.visible = false;
				_keyText2.color = 0xFF000000;
				parent.add(_keyText2);
			}
		}
		
		public function show(x:int, y:int, key1:String, key2:String = ""):void	
		{
			_keyText.text = key1;
			
			_keyText.visible = true;
			_keyText.x = x + 11;
			_keyText.y = y - 4;
			
			if (_keyText2 != null)
			{
				_keyText2.text = key2;
				_keyText2.visible = true;
				_keyText2.x = x + 32;
				_keyText2.y = y - 4;
			}
			
			_keySprite.visible = true;
			_keySprite.x = x;
			_keySprite.y = y - 10;
		}
		
		public function hide():void
		{
			_keyText.visible = false;
			_keySprite.visible = false;
			
			if (_keyText2 != null)
			{
				_keyText2.visible = false;
			}
		}
		
	}
}