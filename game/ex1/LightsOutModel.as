package
{
	
	/**
	 * ...
	 * @author Ryan Duan
	 */
	internal class LightsOutModel
	{
		private const numLightsRow:int = 5;
		private const numLightsCol:int = 5;
		
		private var moveCnt:int = 0;
		private var bInWinState:Boolean = false;
		private var boardCfg:Array = new Array(numLightsRow);
		
		public function LightsOutModel()
		{
			for (var i:int = 0; i < numLightsRow; i++)
			{
				boardCfg[i] = new Array(numLightsCol);
			}
		}
	
	}

}