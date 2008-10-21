package simplemodule.view {
	import mx.controls.Text;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import shell.model.CounterProxy;
	
	import simplemodule.SimpleModuleConstants;
	import simplemodule.view.components.MessageCount;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class MessageCountMediator extends FlexMediator {
		
		static public const NAME:String = "MessageCountMediator";
		
		public function MessageCountMediator(viewComponent:MessageCount) {
			super(NAME, viewComponent);
		}
		
		public function get messageCount():MessageCount {
			return viewComponent as MessageCount;
		}
		
		public function get shellMessageText():Text {
			return messageCount.shellMessageText as Text;
		}
		
		public function get moduleMessageText():Text {
			return messageCount.moduleMessageText as Text;
		}
		
		override public function onRegister():void {
			updateShellMessageText();
			updateModuleMessageText();
		}
		
		/* *
		override public function listNotificationInterests():Array {
			return [shellCountChangedNotification,
					 moduleCountChangedNotification];
		}
		
		override public function handleNotification(note:INotification):void {
			var noteName:String = note.getName();
			if (noteName == shellCountChangedNotification) {
				updateShellMessageText();
			} else {
				updateModuleMessageText();
			}
		} 
		/* */
		
		public function respondToModuleMessageCountProxy(note:INotification):void {
			updateModuleMessageText();
		}
		
		public function respondToShellMessageCountProxy(note:INotification):void {
			updateShellMessageText();
		}
		
		private function updateShellMessageText():void {
			var counterProxy:CounterProxy = retrieveProxy(SimpleModuleConstants.SHELL_MESSAGE_COUNT_PROXY) as CounterProxy;
			shellMessageText.text = "Shell[" + counterProxy.count + "]";
		}
		
		private function updateModuleMessageText():void {
			var counterProxy:CounterProxy = retrieveProxy(SimpleModuleConstants.MODULE_MESSAGE_COUNT_PROXY) as CounterProxy;
			moduleMessageText.text = "Module[" + counterProxy.count + "]";
		}
		 
	}
}
