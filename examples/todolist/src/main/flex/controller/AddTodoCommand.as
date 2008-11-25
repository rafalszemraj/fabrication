package controller {
	import model.TodoListProxy;
	
	import vo.TodoItem;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.undoable.AbstractUndoableCommand;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class AddTodoCommand extends AbstractUndoableCommand {
		
		override public function execute(note:INotification):void {
			var todoListProxy:TodoListProxy = retrieveProxy(TodoListProxy.NAME) as TodoListProxy;
			todoListProxy.add(note.getBody() as TodoItem);
		}
		
		override public function unexecute(note:INotification):void {
			var todoListProxy:TodoListProxy = retrieveProxy(TodoListProxy.NAME) as TodoListProxy;
			todoListProxy.remove(note.getBody() as TodoItem);
		}
		
	}
}
