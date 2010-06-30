package org.puremvc.as3.demos.flash.helloflash.shell.view {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.puremvc.as3.demos.flash.helloflash.shell.HelloFlash;
	import org.puremvc.as3.demos.flash.helloflash.shell.HelloFlashConstants;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlashApplication;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlashMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class HelloFlashMediator extends FlashMediator {

		static public const NAME:String = "HelloFlashMediator";
		
		private var navModuleLoader:Loader;

		public function HelloFlashMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}

		public function get helloFlash():HelloFlash {
			return viewComponent as HelloFlash;
		}

		override public function onRegister():void {
			facade.registerMediator(new StageMediator(helloFlash.stage));
			loadNavModule();
		}
		
		public function respondToChangeBackgroundColor(note:INotification):void {
			helloFlash.opaqueBackground = note.getBody() as int;
		}
		
		public function respondToIncreaseSize(note:INotification):void {
			sendNotification(HelloFlashConstants.SPRITE_SCALE, 10);
		}
		
		private function loadNavModule():void {
			navModuleLoader = new Loader();
			navModuleLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeListener);
			navModuleLoader.load(new URLRequest("NavModule.swf"));
		}
		
		private function completeListener(event:Event):void {
			var content:FlashApplication = navModuleLoader.content as FlashApplication;
			content.router = applicationRouter;
			content.defaultRouteAddress = applicationAddress;
			
			helloFlash.addChild(content);
			
			navModuleLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeListener);
			navModuleLoader = null;
		}
		
	}
}
