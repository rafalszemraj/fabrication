package model {
	import vo.TodoItem;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;
	
	import mx.collections.ArrayCollection;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoListProxy extends FabricationProxy {
		
		static public const NAME:String = "TodoListProxy";
		
		public function TodoListProxy($todos:ArrayCollection = null) {
			super(NAME, $todos != null ? $todos : new ArrayCollection());
		}

		public function get todos():ArrayCollection {
			return data as ArrayCollection;
		}
		
		public function add(item:TodoItem):void {
			addAt(item, todos.length);
		}
		
		public function remove(item:TodoItem):void {
			var index:int = todos.getItemIndex(item);
			removeAt(item, index);
		}
		
		public function addAt(item:TodoItem, index:int):void {
			todos.addItemAt(item, index);
			sendTodoNotification(TodoListNotification.TODO_ADDED, item, index);
		}
		
		public function removeAt(item:TodoItem, index:int):void {
			todos.removeItemAt(index);
			sendTodoNotification(TodoListNotification.TODO_REMOVED, item, index);
		}
		
		public function getAt(item:TodoItem):int {
			return todos.getItemIndex(item);
		}
		
		public function sendTodoNotification(name:String, item:TodoItem, index:int):void {
			fabFacade.notifyObservers(new TodoListNotification(name, item, index));			
		}
		
	}
}
