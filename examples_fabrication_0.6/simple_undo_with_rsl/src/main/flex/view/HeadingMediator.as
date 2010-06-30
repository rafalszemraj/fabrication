package view {
	import mx.controls.Text;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import model.HeadingProxy;
	
	import view.components.Heading;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class HeadingMediator extends FlexMediator {
		
		static public const NAME:String = "HeadingMediator";
		
		public function HeadingMediator(viewComponent:Heading) {
			super(NAME, viewComponent);
		}
		
		public function get heading():Heading {
			return viewComponent as Heading;
		}
		
		public function get headingText():Text {
			return heading.headingText as Text;
		}
		
		override public function onRegister():void {
			updateHeadingText();
		}
		
		public function respondToHeadingChanged(note:INotification):void {
			updateHeadingText();
		}
		
		private function updateHeadingText():void {
			var headingProxy:HeadingProxy = retrieveProxy(HeadingProxy.NAME) as HeadingProxy;
			headingText.text = headingProxy.heading;
		}
	}
}
