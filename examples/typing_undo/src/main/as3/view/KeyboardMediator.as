package view {
	import model.TextProxy;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlashMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.observer.FabricationNotification;
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class KeyboardMediator extends FlashMediator {
		
		static public const NAME:String = "KeyboardMediator";
		
		private var textProxy:TextProxy;
		
		public function KeyboardMediator(viewComponent:Object):void {
			super(NAME, viewComponent);
		}
		
		override public function dispose():void {
			textProxy = null;
		}
		
		public function get application():MovieClip {
			return viewComponent as MovieClip;
		}
		
		override public function onRegister():void {
			textProxy = retrieveProxy(TextProxy.NAME) as TextProxy;
			application.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownListener, true);
		}
		
		private function keyDownListener(event:KeyboardEvent):void {
			var charCode:uint = event.charCode;
			//trace("charCode [" + charCode + "]");
			
			if (charCode == Keyboard.BACKSPACE && textProxy.text.length > 0) {
				sendNotification(TypingUndoConstants.BACKSPACE_TYPED);
			} else if (charCode == Keyboard.ENTER) {
				sendNotification(TypingUndoConstants.KEY_TYPED, "\r");
			} else if (charCode == Keyboard.TAB) {
				sendNotification(TypingUndoConstants.KEY_TYPED, "\t");
			} else {
				if (charCode < 32) {
					return;
				}
				
				var char:String = String.fromCharCode(charCode);
				
				if (!event.ctrlKey) {
					if (event.shiftKey) {
						char = char.toUpperCase();
					}
					
					sendNotification(TypingUndoConstants.KEY_TYPED, char);
				} else if (event.ctrlKey && char.toUpperCase() == "Z") {
					sendNotification(FabricationNotification.UNDO);
				} else if (event.ctrlKey && char.toUpperCase() == "Y") {
					sendNotification(FabricationNotification.REDO);
				}
			}
		}
		
	}
}
