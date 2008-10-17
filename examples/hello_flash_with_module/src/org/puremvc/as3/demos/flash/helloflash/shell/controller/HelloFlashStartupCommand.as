/*
PureMVC AS3 / Flash Demo - HelloFlash
By Cliff Hall <clifford.hall@puremvc.org>
Copyright(c) 2007-08, Some rights reserved.
 */
package org.puremvc.as3.demos.flash.helloflash.shell.controller {
	import org.puremvc.as3.demos.flash.helloflash.shell.HelloFlashConstants;
	import org.puremvc.as3.demos.flash.helloflash.shell.model.SpriteDataProxy;
	import org.puremvc.as3.demos.flash.helloflash.shell.view.HelloFlashMediator;
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;		

	public class HelloFlashStartupCommand extends SimpleCommand implements ICommand {
		/**
		 * Register the Proxies and Mediators.
		 * 
		 * Get the View Components for the Mediators from the app,
		 * which passed a reference to itself on the notification.
		 */
		override public function execute( note:INotification ):void {
			facade.registerProxy(new SpriteDataProxy());
			facade.registerMediator(new HelloFlashMediator(note.getBody()));
			
			sendNotification(HelloFlashConstants.STAGE_ADD_SPRITE);
		}
	}
}