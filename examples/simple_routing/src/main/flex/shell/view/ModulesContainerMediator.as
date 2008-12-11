package shell.view {
	import flash.display.DisplayObject;
	
	import mx.core.Container;
	import mx.events.ModuleEvent;
	import mx.modules.ModuleLoader;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlexModuleLoader;
	import org.puremvc.as3.multicore.utilities.fabrication.events.FabricatorEvent;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterAwareModule;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import shell.model.ModuleDescriptor;
	import shell.view.components.ModulesContainer;
	
	import trace;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class ModulesContainerMediator extends FlexMediator {

		static public const NAME:String = "ModulesContainerMediator";
		
		private var pendingModules:Array = new Array();
		
		public function ModulesContainerMediator(viewComponent:Object) {
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
			
			if (moduleDescriptor.moduleGroup != null) {
				moduleLoader.moduleGroup = moduleDescriptor.moduleGroup;
				moduleLoader.defaultRoute  = moduleDescriptor.moduleGroup;
			} else {
				moduleLoader.defaultRouteAddress = applicationAddress;
			}
			
			moduleLoader.addEventListener(ModuleEvent.ERROR, moduleError);
			moduleLoader.addEventListener(FabricatorEvent.FABRICATION_CREATED, moduleCreated);
			moduleLoader.addEventListener(FabricatorEvent.FABRICATION_REMOVED, moduleRemoved);
			moduleLoader.addEventListener(ModuleEvent.READY, moduleReady);
			
			pendingModules.push(moduleLoader);
			moduleLoader.loadModule();
		}
		
		private function unloadModule(moduleDescriptor:ModuleDescriptor):void {
			var moduleLoader:FlexModuleLoader = getModuleForDescriptor(moduleDescriptor) as FlexModuleLoader;
			
			modulesContainer.removeChild(moduleLoader);
			moduleLoader.dispose();
		}
		
		private function moduleReady(event:ModuleEvent):void {
			event.target.removeEventListener(ModuleEvent.READY, moduleReady);
			modulesContainer.addChild(event.target as DisplayObject);
			var index:int = findModuleIndex(event.target);
			if (index >= 0) {
				pendingModules.splice(index, 1);
			}
		}
		
		private function moduleCreated(event:FabricatorEvent):void {
			event.target.removeEventListener(FabricatorEvent.FABRICATION_CREATED, moduleCreated);
			trace("moduleCreated " + event.target);
		}
		
		private function moduleRemoved(event:FabricatorEvent):void {
			event.target.removeEventListener(FabricatorEvent.FABRICATION_REMOVED, moduleRemoved);
			trace("moduleRemoved " + event.target);
		}
		
		private function moduleError(event:ModuleEvent):void {
			event.target.removeEventListener(ModuleEvent.ERROR);
			trace("moduleError " + event.errorText);
		}
		
		private function findModuleIndex(module:Object):int {
			var n:int = pendingModules.length;
			var obj:Object;
			for (var i:int = 0; i < n; i++) {
				obj = pendingModules[i];
				if (obj == module) {
					return i;
				}
			}
			
			return -1;
		}
		
	}
}
