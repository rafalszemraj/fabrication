package shell.view {
	import org.puremvc.as3.multicore.utilities.fabrication.events.FabricatorEvent;	
	
	import flash.display.DisplayObject;
	
	import mx.modules.ModuleLoader;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlexModuleLoader;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterAwareModule;
	
	import shell.model.ModuleDescriptor;
	import shell.view.components.ModulesContainer;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class ModulesContainerMediator extends FlexMediator {

		static public const NAME:String = "ModulesContainerMediator";
		
		public function ModulesContainerMediator(viewComponent:ModulesContainer) {
			super(NAME, viewComponent);
		}
		
		public function get modulesContainer():ModulesContainer {
			return viewComponent as ModulesContainer;
		}
		
		public function getModuleForDescriptor(descriptor:ModuleDescriptor):IRouterAwareModule {
			var n:int = modulesContainer.numChildren;
			var child:DisplayObject;
			var module:ModuleLoader;
			var elementID:String = descriptor.getElementID();
			for (var i:int = 0; i < n; i++) {
				child = modulesContainer.getChildAt(i);
				if (child is ModuleLoader) {
					module = child as ModuleLoader;
					if (module != null && module.id == elementID) {
						return module as IRouterAwareModule;
					}
				}
			}
			
			return null;
		}
		
		override public function onRegister():void {
			
		}
		
		/*
		override public function listNotificationInterests():Array {
			return [moduleAddedNotification,
					 moduleRemovedNotification];
		}
		
		override public function handleNotification(note:INotification):void {
			var noteName:String = note.getName();
			var moduleDescriptor:ModuleDescriptor = note.getBody() as ModuleDescriptor;
			if (noteName == moduleAddedNotification) {
				loadModule(moduleDescriptor);
			} else if (noteName == moduleRemovedNotification) {
				unloadModule(moduleDescriptor);
			}
		}
		 * 
		 */

		public function respondToAddedToList(note:INotification):void {
			loadModule(note.getBody() as ModuleDescriptor);
		}
		
		public function respondToRemovedFromList(note:INotification):void {
			unloadModule(note.getBody() as ModuleDescriptor);
		}
		
		private function loadModule(moduleDescriptor:ModuleDescriptor):void {
			var moduleLoader:FlexModuleLoader = new FlexModuleLoader();

			moduleLoader.id = moduleDescriptor.getElementID();
			moduleLoader.url = moduleDescriptor.url;
			moduleLoader.router = applicationRouter;
			moduleLoader.defaultRouteAddress = applicationAddress;
			
			moduleLoader.addEventListener(FabricatorEvent.FABRICATION_CREATED, moduleCreated);
			moduleLoader.addEventListener(FabricatorEvent.FABRICATION_REMOVED, moduleRemoved);
			
			modulesContainer.addChild(moduleLoader);
			moduleLoader.loadModule();
		}
		
		private function unloadModule(moduleDescriptor:ModuleDescriptor):void {
			var moduleLoader:FlexModuleLoader = getModuleForDescriptor(moduleDescriptor) as FlexModuleLoader;
			
			modulesContainer.removeChild(moduleLoader);
			moduleLoader.dispose();
		}
		
		private function moduleCreated(event:FabricatorEvent):void {
			event.target.removeEventListener(FabricatorEvent.FABRICATION_CREATED, moduleCreated);
			trace("moduleCreated " + event.target);
		}
		
		private function moduleRemoved(event:FabricatorEvent):void {
			event.target.removeEventListener(FabricatorEvent.FABRICATION_REMOVED, moduleRemoved);
			trace("moduleRemoved " + event.target);
		}
		
	}
}
