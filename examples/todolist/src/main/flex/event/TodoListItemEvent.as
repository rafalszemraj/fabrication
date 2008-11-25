package event {
	import vo.TodoItem;
	
	import flash.events.Event;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoListItemEvent extends Event {
		
		static public const TODO_LIST_ITEM_CLICK:String = "todoListItemClick";
		
		public var item:TodoItem;
		
		public function TodoListItemEvent(type:String, item:TodoItem):void {
			super(type);
			
			this.item = item;
		}
		
	}
}
