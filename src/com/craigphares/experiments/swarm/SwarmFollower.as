package com.craigphares.experiments.swarm
{
	public class SwarmFollower extends SwarmParticle
	{
		public static const MIN_ROTATION:Number = 0;
		public static const MAX_ROTATION:Number = 10;
		public static const MIN_SPEED:Number = 1;
		public static const MAX_SPEED:Number = 3;
		
		public static const NOISE:Number = 180;
		
		public var leader:SwarmLeader;
		
		public function SwarmFollower()
		{
			super();
			speed = MIN_SPEED + (Math.random() * (MAX_SPEED - MIN_SPEED));
			draw();
		}
		
		public function spawn(x:Number, y:Number, leader:SwarmLeader):void
		{
			pos.x = x;
			pos.y = y;
			this.leader = leader;
		}
		
		public function move():void
		{
			
			var dx:Number = leader.pos.x - pos.x;
			var dy:Number = leader.pos.y - pos.y;
			
			var angle:Number = Math.atan2(dy, dx);
			
			var targetDir:Number = angle * (180 / Math.PI);
			
			var dirNoise:Number = (-NOISE / 2) + (Math.random() * NOISE);
			targetDir += dirNoise;
			
			if (targetDir < 0) targetDir += 360;
			if (targetDir > 360) targetDir -= 360;
			
			//trace('target dir: ' + targetDir);

			var dirDiff:Number = targetDir - dir;
			if (dirDiff < -180) dirDiff += 360;
			if (dirDiff > 180) dirDiff -= 360;
			
			//trace('diff: ' + dirDiff);
			
			var maxRotation:Number = MAX_ROTATION;
			if (Math.abs(dirDiff) < maxRotation) maxRotation = Math.abs(dirDiff);
			
			var turnAmount:Number = MIN_ROTATION + (Math.random() * (maxRotation - MIN_ROTATION));
			//var turnAmount:Number = dirDiff * 0.3;
			
			//trace('turn: ' + turnAmount);
			
			/*
			dir: 0-90
			target: 
			*/
			
			
			var newDir:Number = dir;
			if (dirDiff > 0) newDir += turnAmount;
			else newDir -= turnAmount;
			
			
			//var newDir:Number = dir + turnAmount;
			
			//newDir = targetDir;
			
			if (newDir < 0) newDir += 360;
			if (newDir > 360) newDir -= 360;
			dir = newDir;
			
			//trace('newDir: ' + newDir);
			
			//trace('----');
			
			// move particle
			var vx:Number = speed * Math.cos(dir * (Math.PI / 180));
			var vy:Number = speed * Math.sin(dir * (Math.PI / 180));
			pos.x += vx;
			pos.y += vy;			
			
		}
		
		
		
	}
}