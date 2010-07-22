package simplemodule.view {
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import common.FabricationRoutingDemoConstants;
	
	import simplemodule.view.components.MessageNavBar;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class MessageNavBarMediator extends FlexMediator {

		static public const NAME:String = "MessageNavBarMediator";
		
		public function MessageNavBarMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get messageNavBar():MessageNavBar {
			return viewComponent as MessageNavBar;
		}
		
		public function get messageShellButton():UIComponent {
			return messageNavBar.messageShellButton as UIComponent;
		}
		
		public function get messageModulesButton():UIComponent {
			return messageNavBar.messageModulesButton as UIComponent;
		}
		
		public function get messageGroupButton():UIComponent {
			return messageNavBar.messageGroupButton as UIComponent;
		}
		
		public function  get messageInstancesInGroupButton():UIComponent {
			return messageNavBar.messageInstancesInGroupButton as UIComponent;
		}
		
		override public function onRegister():void {
			messageShellButton.addEventListener(FlexEvent.BUTTON_DOWN, messageShellButtonListener);
			messageModulesButton.addEventListener(FlexEvent.BUTTON_DOWN, messageModulesButtonListener);
			messageGroupButton.addEventListener(FlexEvent.BUTTON_DOWN, messageGroupButtonListener);
			messageInstancesInGroupButton.addEventListener(FlexEvent.BUTTON_DOWN, messageInstanceGroupButtonListener);
		}
		
		override public function onRemove():void {
			messageShellButton.removeEventListener(FlexEvent.BUTTON_DOWN, messageShellButtonListener);
			messageModulesButton.removeEventListener(FlexEvent.BUTTON_DOWN, messageModulesButtonListener);
			messageGroupButton.removeEventListener(FlexEvent.BUTTON_DOWN, messageGroupButtonListener);
			messageInstancesInGroupButton.removeEventListener(FlexEvent.BUTTON_DOWN, messageInstanceGroupButtonListener);
			
			super.onRemove();
		}
		
		private function messageShellButtonListener(event:FlexEvent):void {
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Module", null, "FabricationRoutingDemoShell/*");
		}
		
		private function messageModulesButtonListener(event:FlexEvent):void {
			var to:String = fabrication.moduleAddress.getClassName() + "/*";
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Module", null, to);
		}
		
		private function messageGroupButtonListener(event:FlexEvent):void {
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Module", null, fabrication.moduleGroup);
		}

		private function messageInstanceGroupButtonListener(event:FlexEvent):void {
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Module", null, "SimpleModule/*");
		}
		
	}
}
