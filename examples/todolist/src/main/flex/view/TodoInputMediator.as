package view {
	import view.components.TodoInput;
	
	import vo.TodoItem;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import mx.controls.Button;
	import mx.controls.TextInput;
	import mx.events.FlexEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoInputMediator extends FlexMediator {
		
		static public const NAME:String = "TodoInputMediator";
		
		public function TodoInputMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get todoInput():TodoInput {
			return viewComponent as TodoInput;
		}
		
		public function get inputField():TextInput {
			return todoInput.inputField as TextInput;
		}
		
		public function get addButton():Button {
			return todoInput.addButton as Button;
		}
		
		public function get advancedButton():Button {
			return todoInput.advancedButton as Button;
		}
		
		override public function onRegister():void {
			inputField.addEventListener(FlexEvent.ENTER, addTodoItem);
			addButton.addEventListener(MouseEvent.CLICK, addTodoItem);
			advancedButton.addEventListener(MouseEvent.CLICK, showAdvancedDialog);
		}
		
		private function addTodoItem(event:Event):void {
			if (!validateInput()) {
				return;
			}
			
			var todoItem:TodoItem = new TodoItem(inputField.text);
			sendNotification(TodoListConstants.ADD_TODO, todoItem);
			
			inputField.text = "";
		}
		
		private function showAdvancedDialog(event:MouseEvent):void {
			sendNotification(TodoListConstants.SHOW_ADVANCED_DIALOG);
		}
		
		private function validateInput():Boolean {
			if (inputField.text == "") {
				inputField.setFocus();
				return false;
			}
			
			return true;
		}		
		
	}
}
