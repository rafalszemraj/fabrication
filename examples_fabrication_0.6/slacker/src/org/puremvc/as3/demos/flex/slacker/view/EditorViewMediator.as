/*
PureMVC AS3 / Flex Demo - Slacker 
Copyright (c) 2008 Clifford Hall <clifford.hall@puremvc.org>
Your reuse is governed by the Creative Commons Attribution 3.0 License
 */
package org.puremvc.as3.demos.flex.slacker.view {
	import flash.events.Event;
	
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.demos.flex.slacker.view.components.EditorView;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	

	public class EditorViewMediator extends FlexMediator {
		public static const NAME:String = 'EditorViewMediator';

		public function EditorViewMediator( viewComponent:Object ) {
			super(NAME, viewComponent);   
		}

		override public function onRegister():void {
			editorView.message.text = "Hello from the newly registered " + NAME;
			editorView.addEventListener(FlexEvent.HIDE, onHide);
		}

		protected function onHide(event:Event):void {
			editorView.message.text = "Hi there, its your old friend " + NAME;
			editorView.removeEventListener(FlexEvent.HIDE, onHide);
		}   

		
		protected function get editorView():EditorView {
			return viewComponent as EditorView;
		}
	}
}