/*
PureMVC AS3 / Flex Demo - Slacker 
Copyright (c) 2008 Clifford Hall <clifford.hall@puremvc.org>
Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.slacker.view {
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.demos.flex.slacker.view.components.GalleryView;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	

	public class GalleryViewMediator extends FlexMediator {
		public static const NAME:String = 'GalleryViewMediator';

		public function GalleryViewMediator( viewComponent:Object ) {
			super(NAME, viewComponent);   
		}

		override public function onRegister():void {
			galleryView.message.text = "Hello from the newly registered " + NAME;
			galleryView.addEventListener(FlexEvent.HIDE, onHide);
		}

		protected function onHide(event:Event):void {
			galleryView.message.text = "Hi there, its your old friend " + NAME;
			galleryView.removeEventListener(FlexEvent.HIDE, onHide);
		}   

		protected function get galleryView():GalleryView {
			return viewComponent as GalleryView;
		}
	}
}