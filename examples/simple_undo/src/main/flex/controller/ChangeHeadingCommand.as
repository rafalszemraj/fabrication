package controller {
	import model.HeadingProxy;	
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.undoable.SimpleUndoableCommand;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class ChangeHeadingCommand extends SimpleUndoableCommand {
		
		override public function initializeUndoableCommand(note:INotification):void {
			super.initializeUndoableCommand(note);
			
			var headingProxy:HeadingProxy = retrieveProxy(HeadingProxy.NAME) as HeadingProxy;
			
			saveBeginState(note.getBody() as String);
			saveCancelState(headingProxy.heading);
		}

		override protected function commit(state:Object):void {
			var headingProxy:HeadingProxy = retrieveProxy(HeadingProxy.NAME) as HeadingProxy;
			headingProxy.changeHeading(state as String);			
		}
		
	}
}
