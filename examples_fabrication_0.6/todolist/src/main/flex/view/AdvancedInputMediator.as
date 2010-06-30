package view {
	import view.components.AdvancedInput;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import mx.controls.Button;
	import mx.controls.TextArea;
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import flash.events.MouseEvent;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class AdvancedInputMediator extends FlexMediator {
		
		static public const NAME:String = "AdvancedInputMediator";
		
		public function AdvancedInputMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get advancedInput():AdvancedInput {
			return viewComponent as AdvancedInput;
		}
		
		public function get todosTextArea():TextArea {
			return advancedInput.todosTextArea as TextArea;
		}
		
		public function get addButton():Button {
			return advancedInput.addButton as Button;
		}
		
		override public function onRegister():void {
			addButton.addEventListener(MouseEvent.CLICK, addTodoList);
			advancedInput.addEventListener(CloseEvent.CLOSE, closeWindow);
			todosTextArea.setFocus();
		}
		
		override public function onRemove():void {
			addButton.removeEventListener(MouseEvent.CLICK, addTodoList);
			advancedInput.removeEventListener(CloseEvent.CLOSE, closeWindow);
			
			super.onRemove();
		}
		
		private function closeWindow(event:CloseEvent):void {
			PopUpManager.removePopUp(advancedInput as IFlexDisplayObject);
			removeMediator(getMediatorName());
		}
		
		private function addTodoList(event:MouseEvent):void {
			if (!validate()) {
				todosTextArea.setFocus();
				return;
			}
			
			sendNotification(TodoListConstants.ADD_TODOS_FROM_LIST, todosTextArea.text);
			closeWindow(null);
		}
		
		private function validate():Boolean {
			if (todosTextArea.text == "") {
				return false;
			}
			
			return true;
		}
		
	}
}
