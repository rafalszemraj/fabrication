package shell.controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;

	import flash.net.LocalConnection;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class ForceGarbageCollectionCommand extends SimpleFabricationCommand {

		override public function execute(note:INotification):void {
			try {
				var connection1:LocalConnection = new LocalConnection();
				var connection2:LocalConnection = new LocalConnection();
				
				connection1.connect(fabrication.fabricator.applicationInstanceName);
				connection2.connect(fabrication.fabricator.applicationInstanceName);
			} catch (e:Error) {
				// no-op
			} finally {
				connection1 = null;
				connection2 = null;
			}
		}
	}
}
