package view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlashMediator;
	
	import flash.display.MovieClip;
	import flash.text.TextField;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class TypingUndoMediator extends FlashMediator {
		
		static public const NAME:String = "TypingUndoMediator";
		
		public function TypingUndoMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get application():MovieClip {
			return viewComponent as MovieClip;
		}
		
		override public function onRegister():void {
			var textField:TextField = new TextField();
			application.addChild(textField);
			
			registerMediator(new TextFieldMediator(textField));
			registerMediator(new KeyboardMediator(application));
		}
	}
}
