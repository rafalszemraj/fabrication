package view {
	import flash.utils.getTimer;
	
	import mx.containers.VBox;
	import mx.controls.Text;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class PanelContentMediator extends FlexMediator {
		
		static public const NAME:String = "PanelContentMediator";
		
		public function PanelContentMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get content():VBox {
			return viewComponent as VBox;
		}
		
		public function get statusText():Text {
			return content.getChildAt(0) as Text;
		}
		
		override public function onRegister():void {
			//content.setStyle("backgroundColor", Math.random() * 0xFFFFFF);
			statusText.text = "Panel content written by " + 
				"\r" + getMediatorName() +
				"\rcreated " + (getTimer()/1000) + " seconds after intialization";
		} 
		
	}
}
