package
{
	import world.RandomKeyManager;
	
	public class Globals
	{
		static public const randomKeyMgr:RandomKeyManager = new RandomKeyManager();

		static public function getGameWidth():uint
		{
			return 320;
		}

		static public function getGameHeight():uint
		{
			return 240;
		}
	}
}