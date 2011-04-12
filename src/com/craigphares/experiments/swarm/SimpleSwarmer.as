package com.craigphares.experiments.swarm
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class SimpleSwarmer
	{
		public static const DEFAULT_WIDTH:int = 10;
		public static const DEFAULT_HEIGHT:int = 10;
		
		public static const D2R:Number = Math.PI / 180;	// convert degrees to radians
		public static const R2D:Number = 180 / Math.PI;	// convert radians to degrees
		
		public var targetPosition:Point;	// goal point
		public var speed:Number;			// speed of travel
		public var turnAmount:Number;		// percent of rotation towards goal
		public var noise:Number;			// variation added to turns	

		public var pos:Point;				// current position
		public var dir:Number;				// current direction
		
		public var src:BitmapData;			// source bitmap data
		public var bmp:BitmapData;			// current bitmap data
		public var width:int;				// width of bitmap
		public var height:int;				// height of bitmap
		
		public function SimpleSwarmer()
		{
			width = DEFAULT_WIDTH;
			height = DEFAULT_HEIGHT;
			pos = new Point();
			targetPosition = pos;
			dir = 0;
			
			//bmp = new BitmapData(width, height);
			
			src = new BitmapData(7, 7, true, 0x00000000);			
			src.setPixel32(6, 3, 0xff00ff00);			
			src.setPixel32(5, 2, 0xff00ff00);
			src.setPixel32(5, 3, 0xff00ff00);
			src.setPixel32(5, 4, 0xff00ff00);			
			src.setPixel32(4, 1, 0xff00ff00);
			src.setPixel32(4, 3, 0xff00ff00);			
			src.setPixel32(4, 5, 0xff00ff00);			
			src.setPixel32(3, 3, 0xff00ff00);			
			src.setPixel32(2, 3, 0xff00ff00);			
			src.setPixel32(1, 3, 0xff00ff00);			
			src.setPixel32(0, 3, 0xff00ff00);
			
			width = 7;
			height = 7;
			bmp = src.clone();
			
			
		}
		
		public function move():void
		{
			var angle:Number = Math.atan2(targetPosition.y - pos.y, targetPosition.x - pos.x) * R2D;
			var delta:Number = (angle - dir) * D2R;
			// determine shortest distance
			var deltaAngle:Number = Math.atan2(Math.sin(delta), Math.cos(delta)) * R2D;
			// update direction and position
			dir += deltaAngle * turnAmount + ((Math.random() * noise * 2) - noise);
			pos.x += Math.cos(dir * D2R) * speed;
			pos.y += Math.sin(dir * D2R) * speed;
			
			// rotate the bitmap
			var rotateMatrix:Matrix = new Matrix();
			rotateMatrix.translate(-width / 2, -height / 2);
			rotateMatrix.rotate(dir * D2R);
			rotateMatrix.translate(width / 2, height / 2);
			var rotateBmp:BitmapData = new BitmapData(width, height, true, 0x00000000);
			rotateBmp.draw(src, rotateMatrix, null, null, null, true);
			bmp = rotateBmp;								
		}
	}
}