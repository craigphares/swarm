package com.craigphares.experiments.swarm
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class DoubleBuffer extends Bitmap
	{
		public static const DEFAULT_WIDTH:int = 640;
		public static const DEFAULT_HEIGHT:int = 480;
		
		public var primaryBuffer:BitmapData;
		public var backBuffer:BitmapData;
		public var origin:Point = new Point();
		
		public function DoubleBuffer(width:int = DEFAULT_WIDTH, height:int = DEFAULT_HEIGHT)
		{
			primaryBuffer = new BitmapData(width, height, true, 0xff000000);
			backBuffer = new BitmapData(width, height, true, 0xff000000);
			super(primaryBuffer);
			//super(backBuffer);
		}
		
		public function clear():void
		{
			backBuffer.fillRect(backBuffer.rect, 0xff000000);
		}
		
		public function flip():void
		{
			
			backBuffer.unlock();
			primaryBuffer.copyPixels(backBuffer, backBuffer.rect, origin, null, null, false);
			backBuffer.lock();
			
		}
	}
}