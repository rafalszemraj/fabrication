package controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import view.AddChildDemoMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class AddChildDemoStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerMediator(new AddChildDemoMediator(note.getBody()));
		}
		
	}
}
