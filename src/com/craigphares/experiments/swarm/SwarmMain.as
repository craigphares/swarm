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
		public static const DEFAULT_WIDTH:Number = 640;
		public static const DEFAULT_HEIGHT:Number = 480;
		public static const NUM_FOLLOWERS:int = 42;
		
		public var screenWidth:Number;
		public var screenHeight:Number;
		
		public var screen:Bitmap;
		public var leader:SwarmLeader;
		public var followers:Array;
		
		protected var timer:Timer;
		
		public function SwarmMain()
		{
			super();
			
			// save the screen size
			screenWidth = DEFAULT_WIDTH;
			screenHeight = DEFAULT_HEIGHT;

			// create the screen
			screen = new Bitmap();
			addChild(screen);
			
			// setup drawing
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			timer = new Timer(1);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			trace('swarm initiated');
		}
		
		public function spawnLeader():void
		{
			var px:Number = Math.random() * screenWidth;
			var py:Number = Math.random() * screenHeight;
			
			trace('spawn leader at ' + px + ', ' + py);
			
			leader = new SwarmLeader();
			leader.spawn(px, py);
		}
		
		public function spawnFollowers():void
		{
			followers = new Array();
			for (var i:int = 0; i < NUM_FOLLOWERS; i++) {
				
				var px:Number = Math.random() * screenWidth;
				var py:Number = Math.random() * screenHeight;

				var follower:SwarmFollower = new SwarmFollower();
				follower.spawn(px, py, leader);
				
				followers.push(follower);
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
				leader.reflectHorizontal();
			}
			if (leader.pos.y < 0 || leader.pos.y > screenHeight) {
				//if (leader.pos.y < 0) leader.pos.y = 0;
				//if (leader.pos.y > screenHeight) leader.pos.y = screenHeight;
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