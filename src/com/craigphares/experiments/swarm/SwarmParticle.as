package com.craigphares.experiments.swarm
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class SwarmParticle
	{
		public static const DEFAULT_DIR:Number = 0;
		public static const DEFAULT_COLOR:uint = 0xffffffff;
		
		public var pos:Point;
		public var tar:Point;
		public var speed:Number;
		public var color:uint;
		
		public var src:BitmapData;
		public var bmp:BitmapData;		

		private var _dir:Number;

		public function SwarmParticle()
		{
			pos = new Point();
			tar = new Point();			
			_dir = DEFAULT_DIR;
			speed = Defaults.DEFAULT_SPEED;			
			color = DEFAULT_COLOR;
		}
		
		public function get dir():Number { return _dir; }
		public function set dir(value:Number):void
		{
			_dir = value;
			if (_dir < 0) _dir += 360;
			if (_dir > 360) _dir -= 360;
			var rotateMatrix:Matrix = new Matrix();
			rotateMatrix.translate(-src.width / 2, -src.height / 2);
			rotateMatrix.rotate((dir + 90) * (Math.PI / 180));
			rotateMatrix.translate(src.width / 2, src.height / 2);
			var rotateBmp:BitmapData = new BitmapData(src.width, src.height, true, 0x00000000);
			rotateBmp.draw(src, rotateMatrix, null, null, null, true);
			bmp = rotateBmp;			
		}
		
		public function draw():void
		{
			src = new BitmapData(7, 7, true, 0x00000000);
			src.setPixel32(3, 0, color);
			src.setPixel32(2, 1, color);
			src.setPixel32(3, 1, color);
			src.setPixel32(4, 1, color);
			src.setPixel32(1, 2, color);
			src.setPixel32(3, 2, color);			
			src.setPixel32(5, 2, color);
			src.setPixel32(3, 3, color);
			src.setPixel32(3, 4, color);
			src.setPixel32(3, 5, color);
			src.setPixel32(3, 6, color);
			
			bmp = src.clone();			
		}
				
	}
}