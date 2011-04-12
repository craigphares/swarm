package com.craigphares.experiments.swarm
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class SwarmMain extends GameLoop
	{		
		/* new properties */
		
		public var targetPosition:Point;	// goal point
		public var speed:Number;			// speed of travel
		public var turnAmount:Number;		// percent of rotation towards goal
		public var noise:Number;			// variation added to turns	
		
		/* existing properties */
		
		public var screenWidth:Number;
		public var screenHeight:Number;
		
		public var swarm:Array;
		
		private var _swarmSize:int;
		private var _wanderAngle_array:Array;
		private var _wanderDistance_array:Array;
		private var _wanderSpeed:Number;
		private var _swarmSpeed_array:Array;
		private var _swarmRotation_array:Array;
		
		public function SwarmMain()
		{
			super();

			swarm = new Array();
			
			// save the screen size
			screenWidth = Defaults.DEFAULT_WIDTH;
			screenHeight = Defaults.DEFAULT_HEIGHT;

			_swarmSize = Defaults.DEFAULT_SWARM_SIZE;
			
			wanderAngle = [Defaults.DEFAULT_WANDER_ANGLE_MIN, Defaults.DEFAULT_WANDER_ANGLE_MAX];
			wanderDistance = [Defaults.DEFAULT_WANDER_DISTANCE_MIN, Defaults.DEFAULT_WANDER_DISTANCE_MAX];
			
			wanderSpeed = Defaults.DEFAULT_SPEED;
			
			swarmSpeed = [Defaults.DEFAULT_SPEED_MIN, Defaults.DEFAULT_SPEED_MAX];
			swarmRotation = [Defaults.DEFAULT_ROTATION_MIN, Defaults.DEFAULT_ROTATION_MAX];

			// setup drawing
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			trace('swarm initiated');
		}
		
		public function get swarmSize():int { return _swarmSize; }
		public function set swarmSize(value:int):void {
			_swarmSize = value;
		}
		
		public function get wanderAngle():Array { return _wanderAngle_array; }
		public function set wanderAngle(value:Array):void {
			_wanderAngle_array = value;
		}
		
		public function get wanderDistance():Array { return _wanderDistance_array; }
		public function set wanderDistance(value:Array):void {
			_wanderDistance_array = value;
		}
		
		public function get wanderSpeed():Number { return _wanderSpeed; }
		public function set wanderSpeed(value:Number):void {
			_wanderSpeed = value;
		}
		
		public function get swarmSpeed():Array { return _swarmSpeed_array; }
		public function set swarmSpeed(value:Array):void {
			_swarmSpeed_array = value;
		}
		
		public function get swarmRotation():Array { return _swarmRotation_array; }
		public function set swarmRotation(value:Array):void {
			_swarmRotation_array = value;
		}
		
		public function spawn():void
		{
			var px:Number = Math.random() * screenWidth;
			var py:Number = Math.random() * screenHeight;

			var tx:Number = Math.random() * screenWidth;
			var ty:Number = Math.random() * screenHeight;

			for (var i:int = 0; i < 42; i++) {
				var simpleSwarmer:LineSwarmer = new LineSwarmer();
				simpleSwarmer.pos = new Point(100, 100);
				simpleSwarmer.targetPosition = new Point(tx, ty);
				simpleSwarmer.speed = 10;
				simpleSwarmer.turnAmount = 0.05;
				simpleSwarmer.noise = 1.5;
				swarm.push(simpleSwarmer);
			}
			
		}
		
		override public function main():void
		{
			var targetPoint:Point;
			
			// determine new target goal
			if (Math.random() > 0.8) {
				var tx:Number = Math.random() * screenWidth;
				var ty:Number = Math.random() * screenHeight;
				targetPoint = new Point(tx, ty);
			}
			
			// move swarm
			var swarmMembers:int = swarm.length;
			for (var i:int = 0; i < swarmMembers; i++) {
				if (targetPoint != null) swarm[i].targetPosition = targetPoint;
				swarm[i].move();
			}
		}
		
		override public function drawObjects():void
		{
			// draw leader
			var swarmMembers:int = swarm.length;
			for (var i:int = 0; i < swarmMembers; i++) {
				var swarmMember:LineSwarmer = swarm[i];
				var bmpPos:Point = new Point(swarmMember.pos.x - (swarmMember.width / 2), swarmMember.pos.y - (swarmMember.height / 2));
				//display.backBuffer.copyPixels(swarmMember.bmp, swarmMember.bmp.rect, bmpPos, null, null, true);
				
				var sprite:Sprite = new Sprite();
				var numVertices:int = swarmMember.vertices.length;
				var start:Point = swarmMember.vertices[numVertices - 1];
				sprite.graphics.moveTo(start.x, start.y);
				var iterations:int = (numVertices - 1) / swarmMember.numSegments;
				if (iterations > 0) {
					for (var j:int = numVertices - 1 - iterations; j >= 0; j-=iterations) {
						var vert:Point = swarmMember.vertices[j];
						var alpha:Number = j / numVertices;
						sprite.graphics.lineStyle(1, 0xff0000, alpha);
						sprite.graphics.lineTo(vert.x, vert.y);
					}
				}
				display.backBuffer.draw(sprite);
				
			}
		}
		
		
		protected function onAddedToStage(event:Event):void
		{
			spawn();
		}
		
	}
}