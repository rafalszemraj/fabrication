package shell.view {
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IFabrication;	
	
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	
	import mx.events.ModuleEvent;
	import mx.modules.IModuleInfo;
	import mx.modules.ModuleLoader;
	import mx.modules.ModuleManager;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlexModuleLoader;
	import org.puremvc.as3.multicore.utilities.fabrication.events.FabricatorEvent;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterAwareModule;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import shell.model.ModuleDescriptor;
	import shell.view.components.ModulesContainer;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class ModulesContainerMediator extends FlexMediator {

		static public const NAME:String = "ModulesContainerMediator";
		
		private var pendingModules:Array = new Array();
		
		public function ModulesContainerMediator(viewComponent:ModulesContainer) {
			super(NAME, viewComponent);
		}
		
		public function get modulesContainer():ModulesContainer {
			return viewComponent as ModulesContainer;
		}
		
		public function getModuleForDescriptor(descriptor:ModuleDescriptor):IFabrication {
			var n:int = modulesContainer.numChildren;
			var child:DisplayObject;
			var module:IFabrication;
			var elementID:String = descriptor.getElementID();
			for (var i:int = 0; i < n; i++) {
				child = modulesContainer.getChildAt(i);
				if (child is IFabrication) {
					module = child as IFabrication;
					if (module != null && module.id == elementID) {
						return module as IFabrication;
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
			var module:IModuleInfo = ModuleManager.getModule(moduleDescriptor.url);
			
			module.data = moduleDescriptor;
			module.addEventListener(ModuleEvent.READY, moduleReadyListener);
			
			pendingModules.push(module);
			module.load(ApplicationDomain.currentDomain);
		}
		
		private function unloadModule(moduleDescriptor:ModuleDescriptor):void {
			var module:IFabrication = getModuleForDescriptor(moduleDescriptor);
			
			modulesContainer.removeChild(module as DisplayObject);
			module.dispose();
		}
		
		private function moduleReadyListener(event:ModuleEvent):void {
			var module:IModuleInfo = event.module;
			var moduleDescriptor:ModuleDescriptor = event.module.data as ModuleDescriptor;
			var moduleInstance:Object = event.module.factory.create();
			
			moduleInstance.router = applicationRouter;
			moduleInstance.defaultRouteAddress = applicationAddress;
			moduleInstance.id = moduleDescriptor.getElementID();
			
			moduleInstance.addEventListener(FabricatorEvent.FABRICATION_CREATED, moduleCreated);
			moduleInstance.addEventListener(FabricatorEvent.FABRICATION_REMOVED, moduleRemoved);
			
			modulesContainer.addChild(moduleInstance as DisplayObject);
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
