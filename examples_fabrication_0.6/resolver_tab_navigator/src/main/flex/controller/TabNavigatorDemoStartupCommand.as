package controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import view.TabNavigatorDemoMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class TabNavigatorDemoStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerMediator(new TabNavigatorDemoMediator(note.getBody()));
		}
		
	}
}
