package view {
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.observer.FabricationNotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.observer.UndoableNotification;
	
	import view.components.UndoNav;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class UndoNavMediator extends FlexMediator {
		
		static public const NAME:String = "UndoNavMediator";
		
		public function UndoNavMediator(viewComponent:UndoNav) {
			super(NAME, viewComponent);
		}
		
		public function get undoNav():UndoNav {
			return viewComponent as UndoNav;
		}
		
		public function get undoButton():Button {
			return undoNav.undoButton as Button;
		}
		
		public function get redoButton():Button {
			return undoNav.redoButton as Button;
		}
		
		override public function onRegister():void {
			undoButton.addEventListener(MouseEvent.CLICK, undoButtonListener);
			redoButton.addEventListener(MouseEvent.CLICK, redoButtonListener);
			
			undoButton.enabled = false;
			redoButton.enabled = false;
		}
		
		public function respondToCommandHistoryChanged(note:UndoableNotification):void {
			var undoableNote:UndoableNotification = note as UndoableNotification;
			undoButton.enabled = undoableNote.undoable;
			redoButton.enabled = undoableNote.redoable;
		}
		
		private function undoButtonListener(event:MouseEvent):void {
			sendNotification(FabricationNotification.UNDO);
		}
		
		private function redoButtonListener(event:MouseEvent):void {
			sendNotification(FabricationNotification.REDO);
		}
	}
}
