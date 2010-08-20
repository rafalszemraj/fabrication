package view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class TabNavigatorDemoMediator extends FlexMediator {
		
		static public const NAME:String = "TabNavigatorDemoMediator";
		
		public function TabNavigatorDemoMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get application():TabNavigatorDemo {
			return viewComponent as TabNavigatorDemo;
		}
		
		override public function onRegister():void {

            registerMediator( new PanelContentMediator( application.panel1) );
			registerMediator(new PanelContentMediator(
				resolve(application)..rex("panel[0-9]")
			));
		}
		
	}
}
