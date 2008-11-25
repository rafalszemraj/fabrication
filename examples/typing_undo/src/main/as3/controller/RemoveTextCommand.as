package controller {
	import model.TextProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IUndoableCommand;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.undoable.SimpleUndoableCommand;
	
	import flash.utils.getTimer;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class RemoveTextCommand extends SimpleUndoableCommand {
		
		private var textProxy:TextProxy;
		private var mergeTime:int;
		
		override public function initializeUndoableCommand(note:INotification):void {
			super.initializeUndoableCommand(note);
			
			textProxy = retrieveProxy(TextProxy.NAME) as TextProxy;
			var text:String = textProxy.text;
			
			saveBeginState(text.substring(0, text.length - 1));
			saveCancelState(text);
			mergeTime = getTimer();
		}
		
		override protected function commit(state:Object):void {
			textProxy.text = state as String;
		}
		
		override public function merge(command:IUndoableCommand):Boolean {
			var now:uint = getTimer();
			
			if (command is RemoveTextCommand && 
				 (now - mergeTime) <= TypingUndoConstants.BUFFER_DIFF_MS) {
				saveBeginState((command as RemoveTextCommand).getBeginState());
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
