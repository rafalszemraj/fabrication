/*
PureMVC AS3 / Flex Demo - Slacker 
Copyright (c) 2008 Clifford Hall <clifford.hall@puremvc.org>
Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.slacker.view {
	import org.puremvc.as3.demos.flex.slacker.view.components.MainDisplay;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	

	public class MainDisplayMediator extends FlexMediator {
		public static const NAME:String = 'MainDisplayMediator';

		public function MainDisplayMediator( viewComponent:Object ) {
			super(NAME, viewComponent);   
		}

		override public function onRegister():void {
			registerMediator(new ProfileViewMediator(resolve(mainDisplay)..profileView));
			registerMediator(new GalleryViewMediator(resolve(mainDisplay)..galleryView));
			registerMediator(new EditorViewMediator(resolve(mainDisplay)..editorView));
		}

		public function respondToEditorMode(note:INotification):void {
			mainDisplay.currentViewSelector = MainDisplay.EDITOR;
		}

		public function respondToGalleryMode(note:INotification):void {
			mainDisplay.currentViewSelector = MainDisplay.GALLERY;
		}

		public function respondToProfileMode(note:INotification):void {
			mainDisplay.currentViewSelector = MainDisplay.PROFILE;
		}

		protected function get mainDisplay():MainDisplay {
			return viewComponent as MainDisplay;
		}
	}
}