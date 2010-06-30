/*
PureMVC AS3 / Flash Demo - HelloFlash
By Cliff Hall <clifford.hall@puremvc.org>
Copyright(c) 2007-08, Some rights reserved.
 */
package org.puremvc.as3.demos.flash.helloflash.shell {
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.demos.flash.helloflash.shell.controller.HelloFlashStartupCommand;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlashApplication;	

	public class HelloFlash extends FlashApplication {
		public function HelloFlash() {
			super();
		}
		
		override public function getStartupCommand():Class {
			return HelloFlashStartupCommand;			
		}
		
		override public function getClassByName(classpath:String):Class {
			return getDefinitionByName(classpath) as Class;
		}
	}
}
