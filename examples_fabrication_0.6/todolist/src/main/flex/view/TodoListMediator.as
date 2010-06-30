package view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import mx.containers.ControlBar;			

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoListMediator extends FlexMediator {
		
		static public const NAME:String = "TodoListMediator";
		
		public function TodoListMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get application():TodoList {
			return viewComponent as TodoList;
		}
		
		public function get navBar():ControlBar {
			return application.navBar as ControlBar;
		}
		
		override public function onRegister():void {
			registerMediator(new TodoListDisplayMediator(resolve(application)..todoListDisplay));
			registerMediator(new TodoInputMediator(resolve(navBar).todoInput));
			registerMediator(new TodoHistoryNavMediator(resolve(navBar).historyNav));
		}
		
	}
}
