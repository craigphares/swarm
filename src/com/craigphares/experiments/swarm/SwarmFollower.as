package com.craigphares.experiments.swarm
{
	public class SwarmFollower extends SwarmParticle
	{
		public static const NOISE:Number = 180;
		
		public var leader:SwarmLeader;
		public var _speedRange_array:Array;
		public var _rotationRange_array:Array;
		
		public function SwarmFollower()
		{
			super();
			speedRange = [Defaults.DEFAULT_SPEED_MIN, Defaults.DEFAULT_SPEED_MAX];
			rotationRange = [Defaults.DEFAULT_ROTATION_MIN, Defaults.DEFAULT_ROTATION_MAX];
			draw();
		}
		
		public function get speedRange():Array { return _speedRange_array; }
		public function set speedRange(value:Array):void {
			_speedRange_array = value;
			speed = speedRange[0] + (Math.random() * (speedRange[1] - speedRange[0]));
		}
		
		public function get rotationRange():Array { return _rotationRange_array; }
		public function set rotationRange(value:Array):void {
			_rotationRange_array = value;
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
			
			var dirDiff:Number = targetDir - dir;
			if (dirDiff < -180) dirDiff += 360;
			if (dirDiff > 180) dirDiff -= 360;
			
			var maxRotation:Number = rotationRange[1];
			if (Math.abs(dirDiff) < maxRotation) maxRotation = Math.abs(dirDiff);
			
			var turnAmount:Number = rotationRange[0] + (Math.random() * (maxRotation - rotationRange[0]));			
			
			var newDir:Number = dir;
			if (dirDiff > 0) newDir += turnAmount;
			else newDir -= turnAmount;
			
			if (newDir < 0) newDir += 360;
			if (newDir > 360) newDir -= 360;
			dir = newDir;
			
			// move particle
			var vx:Number = speed * Math.cos(dir * (Math.PI / 180));
			var vy:Number = speed * Math.sin(dir * (Math.PI / 180));
			pos.x += vx;
			pos.y += vy;			
			
		}
		
		
		
	}
}