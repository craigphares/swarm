package com.craigphares.experiments.swarm
{
	import flash.display.BitmapData;

	public class LineSwarmer extends SimpleSwarmer
	{
		public var numSegments:int = 10;	
		public var segments:Array = new Array();
		
		public function LineSwarmer()
		{
			super();
		}
		
		override public function move():void
		{
			super.move();
						
			var actualSegments:int = segments.length;
			
			if (actualSegments >= numSegments) segments.shift();
			segments.push(pos.clone());
			
			
			
		}
	}
}