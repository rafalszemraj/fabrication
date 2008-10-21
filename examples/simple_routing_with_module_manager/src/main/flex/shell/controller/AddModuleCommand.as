package shell.controller {
	import shell.model.ListProxy;	
	import shell.FabricationRoutingDemoShellConstants;	
	import shell.model.ModuleDescriptor;	
	
	import org.puremvc.as3.multicore.interfaces.INotification;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;	
	
	/**
	 * @author Darshan Sawardekar
	 */
	public class AddModuleCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var moduleDescriptor:ModuleDescriptor = note.getBody() as ModuleDescriptor;
			var moduleListProxy:ListProxy = retrieveProxy(ListProxy.NAME) as ListProxy;
			
			moduleListProxy.add(moduleDescriptor);
		}
	}
}
