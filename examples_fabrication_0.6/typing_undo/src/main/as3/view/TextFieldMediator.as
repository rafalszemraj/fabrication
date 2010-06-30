package view {
	import flash.events.Event;	
	
	import model.TextProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlashMediator;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class TextFieldMediator extends FlashMediator {
		
		static public const NAME:String = "TextMediator";
		
		public function TextFieldMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get textField():TextField {
			return viewComponent as TextField;
		}
		
		override public function onRegister():void {
			textField.multiline = true;
			textField.wordWrap = true;
			textField.selectable = false;
			
			var format:TextFormat = new TextFormat();
			format.font = "Century Gothic,Helvetica,Trebuchet MS";
			format.size = 32;
			format.align = TextFormatAlign.CENTER;
			format.bold = false;
			format.color = 0x000000;
			textField.defaultTextFormat = format;
			
			// need to wait one frame for IE,
			// IE does not give valid stageWidth/stageHeight values initially
			textField.addEventListener(Event.ENTER_FRAME, resizeListener);
			
			updateText();
			textField.stage.focus = textField;
		}
		
		public function respondToTextChanged(note:INotification):void {
			updateText();
		}
		
		private function updateText():void {
			var text:String = (retrieveProxy(TextProxy.NAME) as TextProxy).text; 
			textField.text = text;
		}
		
		private function resizeListener(event:Event):void {
			if (textField.hasEventListener(Event.ENTER_FRAME)) {
				textField.removeEventListener(Event.ENTER_FRAME, resizeListener);
			}
			
			var margin:int = 5;
			textField.x = margin;
			textField.y = margin;
			textField.width = textField.stage.stageWidth - 2*margin;
			textField.height = textField.stage.stageHeight - 2*margin;
		}
		
	}
}
