package org.puremvc.as3.demos.flash.helloflash.navmodule.view {
	import org.puremvc.as3.demos.flash.helloflash.common.CommonConstants;	
	
	import fl.events.ColorPickerEvent;	
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.puremvc.as3.demos.flash.helloflash.navmodule.NavModule;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlashMediator;
	
	import fl.controls.Button;
	import fl.controls.ColorPicker;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class NavModuleMediator extends FlashMediator {
		
		static public const NAME:String = "NavModuleMediator";
		
		public function NavModuleMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get navModule():NavModule {
			return viewComponent as NavModule;
		}
		
		public function get sizeButton():Button {
			return navModule["sizeButton"] as Button;			
		} 
		
		public function get backgroundColorPicker():ColorPicker {
			return navModule["backgroundColorPicker"] as ColorPicker;
		} 
		
		public function get spriteCountTextField():TextField {
			return navModule["spriteCountTextField"] as TextField;
		}

		override public function onRegister():void {
			sizeButton.addEventListener(MouseEvent.CLICK, sizeButtonListener);
			backgroundColorPicker.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER, backgroundColorPickerListener);
			backgroundColorPicker.addEventListener(ColorPickerEvent.CHANGE, backgroundColorPickerListener);
		}		
		
		public function respondToSpriteCountChanged(note:INotification):void {
			spriteCountTextField.text = String(note.getBody()); 
		}
		
		private function sizeButtonListener(event:MouseEvent):void {
			routeNotification(CommonConstants.INCREASE_SIZE);
		}
		
		private function backgroundColorPickerListener(event:ColorPickerEvent):void {
			routeNotification(CommonConstants.CHANGE_BACKGROUND_COLOR, event.color);
		}
		
	}
}
