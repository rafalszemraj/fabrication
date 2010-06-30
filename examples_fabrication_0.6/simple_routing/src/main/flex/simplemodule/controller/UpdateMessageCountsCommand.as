package simplemodule.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterMessage;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterNotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	import org.puremvc.as3.multicore.utilities.fabrication.vo.ModuleAddress;
	
	import common.FabricationRoutingDemoConstants;
	
	import shell.model.CounterProxy;
	
	import simplemodule.SimpleModuleConstants;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class UpdateMessageCountsCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var routerNote:IRouterNotification = note as IRouterNotification;
			var message:IRouterMessage = routerNote.getMessage();
			var counterProxy:CounterProxy = calcCounterProxy(message.getFrom(), message.getTo());
			
			if (counterProxy != null) {
				counterProxy.increment();
			}
		}
		
		private function calcCounterProxy(from:String, to:String):CounterProxy {
			var moduleAddress:ModuleAddress = new ModuleAddress();
			moduleAddress.parse(from);
			
			var fromClassName:String = moduleAddress.getClassName();
			var toClassName:String = moduleAddress.getInstanceName();
			
			if (fromClassName == FabricationRoutingDemoConstants.SHELL_NAME) {
				return retrieveProxy(SimpleModuleConstants.SHELL_MESSAGE_COUNT_PROXY) as CounterProxy;
			} else if (fromClassName == FabricationRoutingDemoConstants.SIMPLE_MODULE_NAME){
				return retrieveProxy(SimpleModuleConstants.MODULE_MESSAGE_COUNT_PROXY) as CounterProxy;
			}
			
			return null;			
		}
		
	}
}
