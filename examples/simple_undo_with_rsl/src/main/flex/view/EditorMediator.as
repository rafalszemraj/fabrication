package view {
	import flash.events.Event;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import view.components.Editor;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class EditorMediator extends FlexMediator {
		
		static public const NAME:String = "EditorMediator";
		
		public function EditorMediator(viewComponent:Editor) {
			super(NAME, viewComponent);
		}
		
		public function get editor():Editor {
			return viewComponent as Editor;
		}
		
		override public function onRegister():void {
			editor.addEventListener(Editor.SUBMIT, submitListener);
		} 
		
		private function submitListener(event:Event):void {
			var newHeading:String = editor.input;
			sendNotification(SimpleUndoDemoConstants.CHANGE_HEADING, newHeading);
		}
	}
}
