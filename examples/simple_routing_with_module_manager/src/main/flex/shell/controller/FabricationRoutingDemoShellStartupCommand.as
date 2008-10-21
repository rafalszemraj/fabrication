package shell.controller {
	import common.FabricationRoutingDemoConstants;	
	
	import shell.view.FabricationRoutingDemoShellMediator;	
	import shell.model.CounterProxy;	
	import shell.model.SelectionProxy;	
	import shell.FabricationRoutingDemoShellConstants;	
	import shell.model.ListProxy;	
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	
	/**
	 * @author Darshan Sawardekar
	 */
	public class FabricationRoutingDemoShellStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerProxy(new ListProxy());
			registerProxy(new SelectionProxy());
			registerProxy(new CounterProxy());
			
			registerCommand(FabricationRoutingDemoShellConstants.ADD_MODULE, AddModuleCommand);
			registerCommand(FabricationRoutingDemoShellConstants.REMOVE_MODULE, RemoveModuleCommand);
			registerCommand(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, UpdateMessageCountCommand);
			registerCommand(FabricationRoutingDemoShellConstants.SELECT_MODULE, ChangeSelectedModuleCommand);
			
			registerMediator(new FabricationRoutingDemoShellMediator(note.getBody() as FabricationRoutingDemoShell));
		}
	}
}
