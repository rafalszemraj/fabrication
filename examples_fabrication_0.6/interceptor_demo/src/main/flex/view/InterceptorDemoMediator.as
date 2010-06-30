package view {
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.Text;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class InterceptorDemoMediator extends FlexMediator {
		
		static public const NAME:String = "InterceptorDemoMediator";
		
		public function InterceptorDemoMediator(viewComponent:Object):void {
			super(NAME, viewComponent);
		}
		
		public function get statusText():Text {
			return viewComponent.statusText as Text;
		}
		
		public function get saveButton():Button {
			return viewComponent.saveButton as Button;
		}
		
		override public function onRegister():void {
			super.onRegister();
		}
		
		public function reactToSaveButtonClick(event:MouseEvent):void {
			statusText.text = "";
			sendNotification(InterceptorDemoConstants.SAVE);
		}
		
		public function respondToSave(note:INotification):void {
			statusText.text = "Save Successful at " + new Date();
		}
		
		
	}
}
