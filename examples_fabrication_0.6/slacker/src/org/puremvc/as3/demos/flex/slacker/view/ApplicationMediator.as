/*
PureMVC AS3 / Flex Demo - Slacker 
Copyright (c) 2008 Clifford Hall <clifford.hall@puremvc.org>
Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.slacker.view {
	import flash.events.Event;
	
	import org.puremvc.as3.demos.flex.slacker.SlackerConstants;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	

	public class ApplicationMediator extends FlexMediator {
		public static const NAME:String = 'ApplicationMediator';

		public function ApplicationMediator( viewComponent:Object ) {
			super(NAME, viewComponent);   
		}

		override public function onRegister():void {
			registerMediator(new MainDisplayMediator(app.mainDisplay));
			
			app.addEventListener(Slacker.SHOW_GALLERY, onShowGallery);
			app.addEventListener(Slacker.SHOW_EDITOR, onShowEditor);
			app.addEventListener(Slacker.SHOW_PROFILE, onShowProfile);
		} 

		protected function onShowEditor( event:Event ):void {
			sendNotification(SlackerConstants.EDITOR_MODE);
		}

		protected function onShowGallery( event:Event ):void {
			sendNotification(SlackerConstants.GALLERY_MODE);
		}

		protected function onShowProfile( event:Event ):void {
			sendNotification(SlackerConstants.PROFILE_MODE);
		}

		protected function get app():Slacker {
			return viewComponent as Slacker;
		}
	}
}