package org.puremvc.as3.demos.flash.helloflash.navmodule.controller {
	import org.puremvc.as3.demos.flash.helloflash.navmodule.view.NavModuleMediator;	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class NavModuleStartupCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			registerMediator(new NavModuleMediator(note.getBody()));
		}
		
	}
}
