package controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import interceptor.ConfirmInterceptor;
	
	import view.InterceptorDemoMediator;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class InterceptorDemoStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerMediator(new InterceptorDemoMediator(note.getBody()));
			
			fabFacade.registerInterceptor(InterceptorDemoConstants.SAVE, ConfirmInterceptor);
		}
	}
}
