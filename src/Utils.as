package
{
	public class Utils
	{
		static public function randInt(Low:int, High:int):int
		{
			return Math.floor(Math.random() * (1 + High - Low)) + Low;;
		}
	}
}