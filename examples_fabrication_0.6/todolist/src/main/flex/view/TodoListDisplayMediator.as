package view {
	import event.TodoListItemEvent;
	
	import model.TodoListNotification;
	import model.TodoListProxy;
	
	import view.components.TodoListDisplay;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoListDisplayMediator extends FlexMediator {

		static public const NAME:String = "TodoListDisplayMediator";

		public function TodoListDisplayMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}

		public function get list():TodoListDisplay {
			return viewComponent as TodoListDisplay;
		}

		override public function onRegister():void {
			var todoListProxy:TodoListProxy = retrieveProxy(TodoListProxy.NAME) as TodoListProxy;
			list.dataProvider = todoListProxy.todos;
			list.addEventListener(TodoListItemEvent.TODO_LIST_ITEM_CLICK, listItemClicked);
		}

		// Not needed because we are assigning to the dataProvider directly
		/* */
		public function respondToTodoAdded(note:TodoListNotification):void {
			//var dataProvider:ArrayCollection = list.dataProvider as ArrayCollection;
			//dataProvider.addItemAt(note.item, note.index);
			list.scrollToIndex(note.index);
		}

		public function respondToTodoRemoved(note:TodoListNotification):void {
			//var dataProvider:ArrayCollection = list.dataProvider as ArrayCollection;
			//dataProvider.removeItemAt(note.index);
			list.scrollToIndex(Math.max(0, note.index - 1));
		}
		/* */

		private function listItemClicked(eventObj:TodoListItemEvent):void {
			sendNotification(TodoListConstants.REMOVE_TODO, eventObj.item);
		}		
	}
}
