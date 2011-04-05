package com.craigphares.experiments.swarm
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class SwarmMain extends Sprite
	{		
		public var screenWidth:Number;
		public var screenHeight:Number;
		
		public var screen:Bitmap;
		public var leader:SwarmLeader;
		public var followers:Array;
		
		protected var timer:Timer;
		
		private var _swarmSize:int;
		private var _wanderAngle_array:Array;
		private var _wanderDistance_array:Array;
		private var _wanderSpeed:Number;
		private var _swarmSpeed_array:Array;
		private var _swarmRotation_array:Array;
		
		public function SwarmMain()
		{
			super();

			followers = new Array();

			// save the screen size
			screenWidth = Defaults.DEFAULT_WIDTH;
			screenHeight = Defaults.DEFAULT_HEIGHT;

			_swarmSize = Defaults.DEFAULT_SWARM_SIZE;
			
			wanderAngle = [Defaults.DEFAULT_WANDER_ANGLE_MIN, Defaults.DEFAULT_WANDER_ANGLE_MAX];
			wanderDistance = [Defaults.DEFAULT_WANDER_DISTANCE_MIN, Defaults.DEFAULT_WANDER_DISTANCE_MAX];
			
			wanderSpeed = Defaults.DEFAULT_SPEED;
			
			swarmSpeed = [Defaults.DEFAULT_SPEED_MIN, Defaults.DEFAULT_SPEED_MAX];
			swarmRotation = [Defaults.DEFAULT_ROTATION_MIN, Defaults.DEFAULT_ROTATION_MAX];


			// create the screen
			screen = new Bitmap();
			addChild(screen);
			
			// setup drawing
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			timer = new Timer(1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			trace('swarm initiated');
		}
		
		public function get swarmSize():int { return _swarmSize; }
		public function set swarmSize(value:int):void {
			_swarmSize = value;
			spawnFollowers();
		}
		
		public function get wanderAngle():Array { return _wanderAngle_array; }
		public function set wanderAngle(value:Array):void {
			_wanderAngle_array = value;
			if (leader != null) leader.wanderAngle = wanderAngle;
		}
		
		public function get wanderDistance():Array { return _wanderDistance_array; }
		public function set wanderDistance(value:Array):void {
			_wanderDistance_array = value;
			if (leader != null) leader.wanderDistance = wanderDistance;
		}
		
		public function get wanderSpeed():Number { return _wanderSpeed; }
		public function set wanderSpeed(value:Number):void {
			_wanderSpeed = value;
			if (leader != null) leader.speed = wanderSpeed;
		}
		
		public function get swarmSpeed():Array { return _swarmSpeed_array; }
		public function set swarmSpeed(value:Array):void {
			_swarmSpeed_array = value;
			var numFollowers:int = followers.length;
			if (numFollowers > 0) {
				for (var i:int = 0; i < numFollowers; i++) {
					var follower:SwarmFollower = followers[i];
					follower.speedRange = swarmSpeed;
				}
			}
		}
		
		public function get swarmRotation():Array { return _swarmRotation_array; }
		public function set swarmRotation(value:Array):void {
			_swarmRotation_array = value;
			var numFollowers:int = followers.length;
			if (numFollowers > 0) {
				for (var i:int = 0; i < numFollowers; i++) {
					var follower:SwarmFollower = followers[i];
					follower.rotationRange = swarmRotation;
				}
			}
		}
		
		public function spawnLeader():void
		{
			var px:Number = Math.random() * screenWidth;
			var py:Number = Math.random() * screenHeight;
			
			trace('spawn leader at ' + px + ', ' + py);
			
			leader = new SwarmLeader();
			leader.spawn(px, py);
			leader.wanderAngle = wanderAngle;
			leader.wanderDistance = wanderDistance;
			leader.speed = wanderSpeed
		}
		
		public function spawnFollowers():void
		{
			var followersNeeded:int = swarmSize - followers.length;
			
			trace('followersNeeded: ' + followersNeeded);
			
			if (followersNeeded == 0) return;
			else if (followersNeeded > 0) {
				for (var i:int = 0; i < followersNeeded; i++) {					
					var px:Number = Math.random() * screenWidth;
					var py:Number = Math.random() * screenHeight;					
					var follower:SwarmFollower = new SwarmFollower();
					follower.spawn(px, py, leader);	
					follower.speedRange = swarmSpeed;
					followers.push(follower);					
				}
			} else {
				followers = followers.slice(0, swarmSize);
			}
			
		}
		
		public function step():void
		{
			// draw background
			var bmp:BitmapData = new BitmapData(screenWidth, screenHeight, false, 0x000000);
			
			// update leader
			leader.move();
			
			// check leader boundaries
			if (leader.pos.x < 0 || leader.pos.x > screenWidth) {
				//if (leader.pos.x < 0) leader.pos.x = 0;
				//if (leader.pos.x > screenWidth) leader.pos.x = screenWidth;
				if (leader.pos.x < 0) leader.pos.x = 0;
				if (leader.pos.x > screenWidth) leader.pos.x = screenWidth;
				leader.reflectHorizontal();
			}
			if (leader.pos.y < 0 || leader.pos.y > screenHeight) {
				//if (leader.pos.y < 0) leader.pos.y = 0;
				//if (leader.pos.y > screenHeight) leader.pos.y = screenHeight;
				if (leader.pos.y < 0) leader.pos.y = 0;
				if (leader.pos.y > screenHeight) leader.pos.y = screenHeight;
				leader.reflectVertical();
			}
			
			// draw leader
			bmp.copyPixels(leader.bmp, leader.bmp.rect, leader.pos, null, null, false);
			
			// update and draw followers
			var numFollowers:int = followers.length;
			for (var i:int = 0; i < numFollowers; i++) {
				var follower:SwarmFollower = followers[i];
				follower.move();
				// draw follower
				bmp.copyPixels(follower.bmp, follower.bmp.rect, follower.pos, null, null, false);
			}
			
			screen.bitmapData = bmp;
			
		}
		
		
		protected function onAddedToStage(event:Event):void
		{
			spawnLeader();
			spawnFollowers();
			
			// start drawing
			timer.start();

		}
		
		protected function onTimer(event:TimerEvent):void
		{
			step();
		}
	}
}