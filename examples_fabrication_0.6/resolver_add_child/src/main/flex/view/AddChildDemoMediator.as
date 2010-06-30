package view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import view.ConfirmMediator;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class AddChildDemoMediator extends FlexMediator {
		
		static public const NAME:String = "AddChildDemoMediator";
		
		public function AddChildDemoMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get application():AddChildDemo {
			return viewComponent as AddChildDemo;
		}
		
		override public function onRegister():void {
			registerMediator(new ConfirmMediator(resolve(application)..confirm));
		}
		
	}
}
