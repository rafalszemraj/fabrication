package controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import model.HeadingProxy;
	
	import view.SimpleUndoDemoMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class SimpleUndoDemoStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerProxy(new HeadingProxy("Welcome to Fabrication !!!"));
			registerCommand(SimpleUndoDemoConstants.CHANGE_HEADING, ChangeHeadingCommand);
			registerMediator(new SimpleUndoDemoMediator(note.getBody() as SimpleUndoDemo));			
		}
	}
}
