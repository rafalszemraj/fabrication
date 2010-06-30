package controller {
	import model.TodoListProxy;
	
	import vo.TodoItem;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.undoable.AbstractUndoableCommand;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class RemoveTodoCommand extends AbstractUndoableCommand {
		
		private var storedAt:int;
		
		override public function execute(note:INotification):void {
			var todoListProxy:TodoListProxy = retrieveProxy(TodoListProxy.NAME) as TodoListProxy;
			var item:TodoItem = note.getBody() as TodoItem;
			
			storedAt = todoListProxy.getAt(item);
			todoListProxy.remove(item);
		}
		
		override public function unexecute(note:INotification):void {
			var todoListProxy:TodoListProxy = retrieveProxy(TodoListProxy.NAME) as TodoListProxy;
			todoListProxy.addAt(note.getBody() as TodoItem, storedAt);
		}
		
	}
}
