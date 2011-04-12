package com.craigphares.experiments.swarm
{
	import flash.display.BitmapData;

	public class LineSwarmer extends SimpleSwarmer
	{
		public var numVertices:int = 42;
		public var numSegments:int = 7;
		public var vertices:Array = new Array();
		
		public function LineSwarmer()
		{
			super();
		}
		
		override public function move():void
		{
			super.move();
						
			var totalVertices:int = vertices.length;
			
			if (totalVertices >= numVertices) vertices.shift();
			vertices.push(pos.clone());
			
			
			
		}
	}
}