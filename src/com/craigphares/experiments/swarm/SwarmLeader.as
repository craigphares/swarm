package com.craigphares.experiments.swarm
{
	public class SwarmLeader extends SwarmParticle
	{
		public static const DIR_VARIATION_MIN:Number	= -5;
		public static const DIR_VARIATION_MAX:Number	= 5;
		public static const DIST_VARIATION_MIN:Number	= 1;	
		public static const DIST_VARIATION_MAX:Number	= 10;

		public function SwarmLeader()
		{
			super();
			color = 0xffff0000;
			speed = 3;
			draw();
		}
		
		public function spawn(x:Number, y:Number):void
		{
			pos.x = x;
			pos.y = y;
			findTarget();
		}
		
		public function findTarget():void
		{
			var dirOffset:Number = DIR_VARIATION_MIN + (Math.random() * (DIR_VARIATION_MAX - DIR_VARIATION_MIN));
			var newDir:Number = dir + dirOffset;
			
			if (newDir < 0) newDir += 360;
			if (newDir > 360) newDir -= 360;
			dir = newDir;
			
			var distance:Number = DIST_VARIATION_MIN + (Math.random() * (DIST_VARIATION_MAX - DIST_VARIATION_MIN));
			var offsetX:Number = distance * Math.cos(dir * (Math.PI / 180));
			var offsetY:Number = distance * Math.sin(dir * (Math.PI / 180));
			
			tar.x = pos.x + offsetX;
			tar.y = pos.y + offsetY;			
		}
		
		public function move():void
		{
			var vx:Number = speed * Math.cos(dir * (Math.PI / 180));
			var vy:Number = speed * Math.sin(dir * (Math.PI / 180));
			pos.x += vx;
			pos.y += vy;
			
			var distance:Number = Math.sqrt( Math.pow((tar.x - pos.x), 2) + Math.pow((tar.y - pos.y), 2) );
			if (distance < speed) {
				findTarget();
			}
			
		}
		
	}
}