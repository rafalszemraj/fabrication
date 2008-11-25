package controller {
	import model.TextProxy;

	import view.TypingUndoMediator;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class TypingUndoStartupCommand extends SimpleFabricationCommand {

		override public function execute(note:INotification):void {
			var initialText:String = "";
			initialText = "Start typing and then hit CTRL+Z or CTRL+Y or Backspace.\r"; 
			
			registerCommand(TypingUndoConstants.KEY_TYPED, AddTextCommand);
			registerCommand(TypingUndoConstants.BACKSPACE_TYPED, RemoveTextCommand);
			
			registerProxy(new TextProxy(initialText));
			registerMediator(new TypingUndoMediator(note.getBody()));
		}
	}
}
