package shell.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IFabrication;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import common.FabricationRoutingDemoConstants;
	
	import shell.FabricationRoutingDemoShellConstants;
	import shell.model.SelectionProxy;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class ChangeSelectedModuleCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var module:IFabrication = note.getBody() as IFabrication;
			var selectionProxy:SelectionProxy = retrieveProxy(SelectionProxy.NAME) as SelectionProxy;
			
			if (selectionProxy.changeSelection(module)) {
				routeNotification(FabricationRoutingDemoConstants.SELECTED_MODULE_CHANGED, module);
			}			
		}
		
	}
}
