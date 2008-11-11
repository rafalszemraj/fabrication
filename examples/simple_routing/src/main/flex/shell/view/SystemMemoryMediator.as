package shell.view {
	import flash.events.TimerEvent;	
	import flash.utils.Timer;	
	
	import mx.events.PropertyChangeEvent;	
	import mx.utils.ObjectProxy;	
	import mx.formatters.NumberFormatter;	
	
	import flash.events.Event;	
	import flash.system.System;	
	
	import mx.controls.Text;	
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;import flash.utils.setTimeout;	
	
	/**
	 * @author Darshan Sawardekar
	 */
	public class SystemMemoryMediator extends FlexMediator {
		
		static public const NAME:String = "SystemMemoryMediator";
		
		private var timer:Timer;
		
		public function SystemMemoryMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get memoryText():Text {
			return viewComponent as Text;
		}
		
		override public function onRegister():void {
			updateMemoryText();
			//timer = new Timer(500, 5);
			//timer.addEventListener(TimerEvent.TIMER, timerListener);
			memoryText.addEventListener(Event.ENTER_FRAME, enterFrameListener);
		}
		
		public function respondToAddedToList(note:INotification):void {
			updateMemoryText();
			//setTimeout(updateMemoryText, 500);
			//startTimer();
		}
		
		public function respondToRemovedFromList(note:INotification):void {
			updateMemoryText();
			//setTimeout(updateMemoryText, 500);
			//startTimer();
		}
		
		private function updateMemoryText():void {
			var kb:Number = System.totalMemory / 1024;
			var numberFormatter:NumberFormatter = new NumberFormatter();
			numberFormatter.useThousandsSeparator = true;
			numberFormatter.precision = 0;
			
			memoryText.text = numberFormatter.format(kb) + "K";
		}
		
		private function startTimer():void {
			if (!timer.running) {
				timer.start();
			}
		}
			
		private function timerListener(event:TimerEvent):void {
			updateMemoryText();
		}

		private function enterFrameListener(event:Event):void {
			updateMemoryText();
		}
		
	}
}
