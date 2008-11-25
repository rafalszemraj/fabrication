package model {
	import vo.TodoItem;
	
	import org.puremvc.as3.multicore.patterns.observer.Notification;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoListNotification extends Notification {
		
		static public const TODO_ADDED:String = "todoAdded";
		static public const TODO_REMOVED:String = "todoRemoved";
		
		public var item:TodoItem;
		public var index:int;

		public function TodoListNotification(name:String, item:TodoItem, index:int) {
			super(name);
			
			this.item = item;
			this.index = index;
		}
		
	}
}
