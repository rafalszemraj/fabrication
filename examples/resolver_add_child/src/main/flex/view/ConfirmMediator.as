package view {
	import flash.events.FocusEvent;
	
	import mx.containers.FormItem;
	import mx.controls.TextInput;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class ConfirmMediator extends FlexMediator {
		
		static public const NAME:String = "ConfirmInputMediator";
		
		public function ConfirmMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get confirm():FormItem {
			return viewComponent as FormItem;
		}
		
		public function get input():TextInput {
			return confirm.getChildAt(0) as TextInput; 
		}
		
		override public function onRegister():void {
			input.text = "[Must be present]";
			input.addEventListener(FocusEvent.FOCUS_IN, focusInListener);
		} 
		
		override public function onRemove():void {
			input.removeEventListener(FocusEvent.FOCUS_IN, focusInListener);
		} 
		
		private function focusInListener(event:FocusEvent):void {
			input.text = "Woot!";
		}
	}
}
