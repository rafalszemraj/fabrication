package controller {
	import model.TextProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IUndoableCommand;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.undoable.SimpleUndoableCommand;
	
	import flash.utils.getTimer;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class AddTextCommand extends SimpleUndoableCommand {
		
		private var mergeTime:int;
		private var textProxy:TextProxy;

		override public function initializeUndoableCommand(note:INotification):void {
			super.initializeUndoableCommand(note);
			
			textProxy = retrieveProxy(TextProxy.NAME) as TextProxy;
			
			saveBeginState(textProxy.text + note.getBody());
			saveCancelState(textProxy.text);
			mergeTime = getTimer();
		}
		
		override protected function commit(state:Object):void {
			textProxy.text = state as String;			
		}
		
		override public function merge(command:IUndoableCommand):Boolean {
			var now:uint = getTimer();
			
			if (command is AddTextCommand && 
				 (now - mergeTime) <= TypingUndoConstants.BUFFER_DIFF_MS) {
				saveBeginState((getBeginState() as String) + command.getNotification().getBody());
				mergeTime = now;
				
				return true;
			}
			
			return false;
		}
		
		override public function dispose():void {
			super.dispose();
			textProxy = null;
		}
		
	}
}
