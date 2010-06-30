package simplemodule.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import simplemodule.view.components.BackgroundCanvas;
	import simplemodule.view.components.MessageCount;
	import simplemodule.view.components.MessageNavBar;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class SimpleModuleMediator extends FlexMediator {
		
		static public const NAME:String = "SimpleModuleMediator";
		
		static public function getDefinitionByName(path:String):Object {
			return getDefinitionByName(path);
		}
		
		public function SimpleModuleMediator(viewComponent:SimpleModule) {
			super(NAME, viewComponent);
		}
		
		public function get application():SimpleModule {
			return viewComponent as SimpleModule;
		}
		
		public function get backgroundCanvas():BackgroundCanvas {
			return application.backgroundCanvas as BackgroundCanvas;
		}
		
		public function get messageCount():MessageCount {
			return application.messageCount as MessageCount;
		}
		
		public function get messageNavBar():MessageNavBar {
			return application.messageNavBar as MessageNavBar;
		}

		override public function onRegister():void {
			/* */
			registerMediator(new BackgroundCanvasMediator(resolve(application)..backgroundCanvas));
			registerMediator(new MessageCountMediator(resolve(application)..messageCount));
			registerMediator(new MessageNavBarMediator(resolve(application)..messageNavBar));
			/* */
			/* *
			registerMediator(new BackgroundCanvasMediator(backgroundCanvas));
			registerMediator(new MessageCountMediator(messageCount));
			registerMediator(new MessageNavBarMediator(messageNavBar));
			/* */
			 
		} 
		
	}
}
