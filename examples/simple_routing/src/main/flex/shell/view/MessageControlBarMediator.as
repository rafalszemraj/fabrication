package shell.view {
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	import mx.controls.Text;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlexModuleLoader;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IFabrication;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterAwareModule;
	
	import common.FabricationRoutingDemoConstants;
	
	import shell.FabricationRoutingDemoShellConstants;
	import shell.model.ListProxy;
	import shell.model.ModuleDescriptor;
	import shell.model.SelectionProxy;
	import shell.view.components.MessageControlBar;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class MessageControlBarMediator extends FlexMediator {

		static public const NAME:String = "MessageControlBarMediator";
		
		public function MessageControlBarMediator(viewComponent:MessageControlBar) {
			super(NAME, viewComponent);
		}
		
		public function get messageControlBar():MessageControlBar {
			return viewComponent as MessageControlBar;
		}
		
		public function get addModuleButton():Button {
			return messageControlBar.addModuleButton as Button;
		}
		
		public function get removeSelectedModuleButton():Button {
			return messageControlBar.removeSelectedModuleButton as Button;
		}
		
		public function get messageAllButton():Button {
			return messageControlBar.messageAllButton as Button;
		}
		
		public function get messageSelectedModuleButton():Button {
			return messageControlBar.messageSelectedModuleButton as Button;
		}
		
		public function get selectedModuleText():Text {
			return messageControlBar.selectedModuleText as Text;
		}
		
		public function get messageCountText():Text {
			return messageControlBar.messageCountText as Text;
		}
		
		override public function onRegister():void {
			addModuleButton.addEventListener(MouseEvent.CLICK, addModuleButtonListener);
			removeSelectedModuleButton.addEventListener(MouseEvent.CLICK, removeSelectedModuleButtonListener);
			messageAllButton.addEventListener(FlexEvent.BUTTON_DOWN, messageAllButtonListener);
			messageSelectedModuleButton.addEventListener(FlexEvent.BUTTON_DOWN, messageSelectionModuleButtonListener);
			
			removeSelectedModuleButton.enabled = false;
			messageSelectedModuleButton.enabled = false;	
			
			selectedModuleText.text = "[No Selection]";
			messageCountText.text = "[No Messages]";
		}
		
		/* *
		override public function listNotificationInterests():Array {
			return [moduleSelectionChangedNotification,
					 moduleMessageCountChangedNotification];
		}
		
		override public function handleNotification(note:INotification):void {
			var noteName:String = note.getName();
			if (noteName == moduleSelectionChangedNotification) {
				var selection:IRouterAwareModule = note.getBody() as IRouterAwareModule;
				
				if (selection != null) {
					selectedModuleText.text = selection.moduleAddress.getClassName();
				} else {
					selectedModuleText.text = "[No Selection]";
				}
				
				removeSelectedModuleButton.enabled = selection != null;
				messageSelectedModuleButton.enabled = selection != null;	
			} else if (noteName == moduleMessageCountChangedNotification) {
				messageCountText.text = "Messages Received [" + (note.getBody() as int) + "]";
			}
		}
		/* */
		
		public function respondToSelectionChanged(note:INotification):void {
			var selection:IFabrication = note.getBody() as IFabrication;
			
			if (selection != null) {
				selectedModuleText.text = selection.moduleAddress.getClassName();
			} else {
				selectedModuleText.text = "[No Selection]";
			}
			
			removeSelectedModuleButton.enabled = selection != null;
			messageSelectedModuleButton.enabled = selection != null;	
		}
		
		public function respondToCountChanged(note:INotification):void {
			messageCountText.text = "Messages Received [" + (note.getBody() as int) + "]";
		}
		
		private function addModuleButtonListener(event:MouseEvent):void {
			/* TODO :: Add modules from a combobox selection */ 
			var moduleDescriptor:ModuleDescriptor = new ModuleDescriptor("SimpleModule.swf");
			sendNotification(FabricationRoutingDemoShellConstants.ADD_MODULE, moduleDescriptor);
		}
		
		private function removeSelectedModuleButtonListener(event:MouseEvent):void {
			var selectionProxy:SelectionProxy = retrieveProxy(SelectionProxy.NAME) as SelectionProxy;
			var selection:IRouterAwareModule = ((selectionProxy.selection as UIComponent).parent as FlexModuleLoader);
			var selectionModule:IFabrication = selection as IFabrication;
			var moduleListProxy:ListProxy = retrieveProxy(ListProxy.NAME) as ListProxy;
			
			var moduleDescriptor:ModuleDescriptor = moduleListProxy.find(selectionModule.id) as ModuleDescriptor;
			sendNotification(FabricationRoutingDemoShellConstants.REMOVE_MODULE, moduleDescriptor);
		}

		private function messageAllButtonListener(event:FlexEvent):void {
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Shell");
		}
		
		private function messageSelectionModuleButtonListener(event:FlexEvent):void {
			var selectionProxy:SelectionProxy = retrieveProxy(SelectionProxy.NAME) as SelectionProxy;
			var module:IRouterAwareModule = selectionProxy.selection as IRouterAwareModule;

			// all three variations of routeNotification work
			//routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Shell", null , module.moduleAddress.getInputName());
			//routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Shell", null , module.moduleAddress.getClassName() + "/" + module.moduleAddress.getInstanceName());
			routeNotification(FabricationRoutingDemoConstants.RECEIVE_MESSAGE, "Message From Shell", null , module.moduleAddress);
		}
		
	}
}
