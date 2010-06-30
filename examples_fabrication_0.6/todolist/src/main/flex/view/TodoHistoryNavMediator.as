package view {
	import view.components.HistoryNav;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.observer.FabricationNotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.observer.UndoableNotification;
	
	import mx.controls.Button;
	
	import flash.events.MouseEvent;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class TodoHistoryNavMediator extends FlexMediator {
		
		static public const NAME:String = "TodoHistoryNavMediator";
		
		public function TodoHistoryNavMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get historyNav():HistoryNav {
			return viewComponent as HistoryNav;
		}
		
		public function get undoButton():Button {
			return historyNav.undoButton as Button;
		}
		
		public function get redoButton():Button {
			return historyNav.redoButton as Button;
		}
		
		override public function onRegister():void {
			undoButton.addEventListener(MouseEvent.CLICK, undoButtonClicked);
			redoButton.addEventListener(MouseEvent.CLICK, redoButtonClicked);
			
			undoButton.enabled = false;
			redoButton.enabled = false;
		}
		
		public function respondToCommandHistoryChanged(note:UndoableNotification):void {
			undoButton.enabled = note.undoable;
			redoButton.enabled = note.redoable;
		}

		private function undoButtonClicked(event:MouseEvent):void {
			sendNotification(FabricationNotification.UNDO);
		}
		
		private function redoButtonClicked(event:MouseEvent):void {
			sendNotification(FabricationNotification.REDO);
		}
		
	}
}
