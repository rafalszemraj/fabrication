package shell.controller {
	import shell.model.CounterProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterAwareModule;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class UpdateMessageCountCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var module:IRouterAwareModule = note.getBody() as IRouterAwareModule;
			var messageCountProxy:CounterProxy = retrieveProxy(CounterProxy.NAME) as CounterProxy;
			
			messageCountProxy.increment();
		}
	}
}
