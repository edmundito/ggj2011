package world
{
	import org.flixel.FlxG;
	
	public class RandomKeyManager
	{
		protected var _keysInUse:Array = [];
		protected var _possibleKeys:String = "";
		
		public function RandomKeyManager()
		{
			var i:uint;
			
			/*
			// Numbers
			for (i = 48; i <= 57; i++)
			{
				_possibleKeys += String.fromCharCode(i);
			}
			*/
			
			// Letters
			for (i = 65; i <= 90; i++)
			{
				_possibleKeys += String.fromCharCode(i);
			}
		}
		
		public function addKeyToIgnoreList(key:String):void
		{
			if (_keysInUse.indexOf(key) < 0)
			{
				_keysInUse.push(key);
			}
		}
		
		public function getFreeKey():String
		{
			var key:String = "";
			
			do
			{
				key = _possibleKeys.charAt(Utils.randInt(0, _possibleKeys.length - 1));
			}
			while (_keysInUse.indexOf(key) >= 0);
			
			_keysInUse.push(key);
			
			FlxG.log("Got random key: " + key);
			
			return key;
		}
		
		public function releaseKey(key:String):void
		{
			var index:int = _keysInUse.indexOf(key);
			
			if (index >= 0)
			{
				_keysInUse.splice(index, 1);
			}
		}
		
	}
}