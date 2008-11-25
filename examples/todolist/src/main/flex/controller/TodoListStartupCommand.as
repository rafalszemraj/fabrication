package controller {
	import model.TodoListProxy;
	
	import view.TodoListMediator;
	
	import vo.TodoItem;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoListStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerCommand(TodoListConstants.ADD_TODO, AddTodoCommand);
			registerCommand(TodoListConstants.REMOVE_TODO, RemoveTodoCommand);
			registerCommand(TodoListConstants.SHOW_ADVANCED_DIALOG, ShowAdvancedDialogCommand);
			registerCommand(TodoListConstants.ADD_TODOS_FROM_LIST, AddTodosFromListCommand);
			
			registerProxy(new TodoListProxy());
			registerMediator(new TodoListMediator(note.getBody()));
			
			sendNotification(TodoListConstants.ADD_TODO, new TodoItem("Buy tea leaves"));
			sendNotification(TodoListConstants.ADD_TODO, new TodoItem("Buy sugar"));
			sendNotification(TodoListConstants.ADD_TODO, new TodoItem("Buy milk"));
			sendNotification(TodoListConstants.ADD_TODO, new TodoItem("Make tea"));
			sendNotification(TodoListConstants.ADD_TODO, new TodoItem("Drink tea"));
		}
		
	}
}
