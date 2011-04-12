package com.craigphares.experiments.swarm
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class GameLoop extends Sprite
	{
		public static const DEFAULT_FPS:int = 30;	// default framerate
		
		public var display:DoubleBuffer;			// double buffer display		
		public var fps:int;							// framerate

		protected var timer:Timer;					// repeated game loop

		public function GameLoop()
		{
			// add the display
			display = new DoubleBuffer();
			addChild(display);
			
			// set the framerate
			fps = DEFAULT_FPS;			
			var delay:Number = 1000 / fps;	
			
			// start the game loop
			timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
		}
		
		public function main():void
		{
			// handle logic
		}
		
		public function drawObjects():void
		{
			// draw objects
		}
		
		protected function draw():void
		{
			display.clear();
			drawObjects();
			display.flip();						
		}
		
		protected function onTimer(e:TimerEvent):void
		{
			// main game process
			main();
			// draw to display
			draw();			
		}		
		
	}
}