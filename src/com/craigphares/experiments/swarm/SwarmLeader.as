package com.craigphares.experiments.swarm
{
	public class SwarmLeader extends SwarmParticle
	{
		private var _wanderAngle_array:Array;
		private var _wanderDistance_array:Array;

		public function SwarmLeader()
		{
			super();
			color = 0xffff0000;
			wanderAngle = [Defaults.DEFAULT_WANDER_ANGLE_MIN, Defaults.DEFAULT_WANDER_ANGLE_MAX];
			wanderDistance = [Defaults.DEFAULT_WANDER_DISTANCE_MIN, Defaults.DEFAULT_WANDER_DISTANCE_MAX];
			draw();
		}
		
		public function get wanderAngle():Array { return _wanderAngle_array; }
		public function set wanderAngle(value:Array):void {
			_wanderAngle_array = value;
		}
		
		public function get wanderDistance():Array { return _wanderDistance_array; }
		public function set wanderDistance(value:Array):void {
			_wanderDistance_array = value;
		}
		
		public function spawn(x:Number, y:Number):void
		{
			pos.x = x;
			pos.y = y;
			findTarget();
		}
		
		public function findTarget():void
		{
			var dirOffset:Number = wanderAngle[0] + (Math.random() * (wanderAngle[1] - wanderAngle[0]));
			var newDir:Number = dir + dirOffset;
			
			if (newDir < 0) newDir += 360;
			if (newDir > 360) newDir -= 360;
			dir = newDir;
			
			var distance:Number = wanderDistance[0] + (Math.random() * (wanderDistance[1] - wanderDistance[0]));
			var offsetX:Number = distance * Math.cos(dir * (Math.PI / 180));
			var offsetY:Number = distance * Math.sin(dir * (Math.PI / 180));
			
			tar.x = pos.x + offsetX;
			tar.y = pos.y + offsetY;			
		}
		
		public function reflectHorizontal():void
		{
			trace('reflectHorizontal: ' + pos.x + ' : ' + dir);
			var vx:Number = speed * Math.cos(dir * (Math.PI / 180));
			var vy:Number = speed * Math.sin(dir * (Math.PI / 180));
			dir = Math.atan2(vy, -vx) * (180 / Math.PI);
			trace('new dir: ' + dir);
			findTarget();
		}
		
		public function reflectVertical():void
		{
			trace('reflectVertical: ' + pos.y + ' : ' + dir);
			var vx:Number = speed * Math.cos(dir * (Math.PI / 180));
			var vy:Number = speed * Math.sin(dir * (Math.PI / 180));
			dir = Math.atan2(-vy, vx) * (180 / Math.PI);
			trace('new dir: ' + dir);
			findTarget();
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