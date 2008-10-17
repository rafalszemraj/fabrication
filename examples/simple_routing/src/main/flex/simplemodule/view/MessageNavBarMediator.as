package simplemodule.view {
	import mx.controls.Button;
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import common.FabricationRoutingDemoConstants;
	
	import simplemodule.view.components.MessageNavBar;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class MessageNavBarMediator extends FlexMediator {

		static public const NAME:String = "MessageNavBarMediator";
		
		public function MessageNavBarMediator(viewComponent:MessageNavBar) {
			super(NAME, viewComponent);
		}
		
		public function get messageNavBar():MessageNavBar {
			return viewComponent as MessageNavBar;
		}
		
		public function get messageShellButton():Button {
			return messageNavBar.messageShellButton as Button;
		}
		
		public function get messageModulesButton():Button {
			return messageNavBar.messageModulesButton as Button;
		}
		
		override public function onRegister():void {
			messageShellButton.addEventListener(FlexEvent.BUTTON_DOWN, messageShellButtonListener);
			messageModulesButton.addEventListener(FlexEvent.BUTTON_DOWN, messageModulesButtonListener);
		}
		
		private function messageShellButtonListener(event:FlexEvent):void {
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Module");
		}
		
		private function messageModulesButtonListener(event:FlexEvent):void {
			var to:String = fabrication.moduleAddress.getClassName() + "/*";
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Module", null, to);
		}
		
	}
}
