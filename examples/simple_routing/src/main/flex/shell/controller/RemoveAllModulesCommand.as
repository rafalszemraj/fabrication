package shell.controller {
	import shell.model.ListProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class RemoveAllModulesCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var moduleListProxy:ListProxy = retrieveProxy(ListProxy.NAME) as ListProxy;
			moduleListProxy.removeAll();		
		}
		
	}
}
