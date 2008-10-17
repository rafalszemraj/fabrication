package org.puremvc.as3.demos.flash.helloflash.navmodule {
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	
	import org.puremvc.as3.demos.flash.helloflash.navmodule.controller.NavModuleStartupCommand;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlashApplication;
	
	import fl.controls.Button;
	import fl.controls.ColorPicker;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class NavModule extends FlashApplication {
		
		public function NavModule() {
			super();
		}
		
		override public function getStartupCommand():Class {
			return NavModuleStartupCommand;
		}
		
		override public function getClassByName(classpath:String):Class {
			return getDefinitionByName(classpath) as Class;
		}
		
	}
}
