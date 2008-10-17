package shell.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import shell.view.components.MessageControlBar;
	import shell.view.components.ModulesContainer;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class FabricationRoutingDemoShellMediator extends FlexMediator {

		static public const NAME:String = "FabricationRoutingDemoShellMediator";
		
		public function FabricationRoutingDemoShellMediator(viewComponent:FabricationRoutingDemoShell) {
			super(NAME, viewComponent);
		}
		
		public function get application():FabricationRoutingDemoShell {
			return viewComponent as FabricationRoutingDemoShell;
		}
		
		public function get messageControlBar():MessageControlBar {
			return application.messageControlBar as MessageControlBar;
		}
		
		public function get modulesContainer():ModulesContainer {
			return application.modulesContainer as ModulesContainer;
		}
		
		override public function onRegister():void {
			registerMediator(new MessageControlBarMediator(messageControlBar));
			registerMediator(new ModulesContainerMediator(modulesContainer));
		}
		
	}
}
