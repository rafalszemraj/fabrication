package simplemodule.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import common.FabricationRoutingDemoConstants;
	
	import shell.model.CounterProxy;
	
	import simplemodule.SimpleModuleConstants;
	import simplemodule.view.SimpleModuleMediator;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class SimpleModuleStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerProxy(new CounterProxy(SimpleModuleConstants.SHELL_MESSAGE_COUNT_PROXY));
			registerProxy(new CounterProxy(SimpleModuleConstants.MODULE_MESSAGE_COUNT_PROXY));
			
			registerCommand(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, UpdateMessageCountsCommand);
			
			registerMediator(new SimpleModuleMediator(note.getBody() as SimpleModule));
		}
		
	}
}
