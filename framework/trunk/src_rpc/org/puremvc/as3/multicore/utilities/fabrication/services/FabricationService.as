package org.puremvc.as3.multicore.utilities.fabrication.services{
    import flash.events.EventDispatcher;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.facade.FabricationFacade;
    import org.puremvc.as3.multicore.utilities.fabrication.injection.DependencyInjector;

    public class FabricationService extends EventDispatcher implements IFabricationService {

        private var injectionFieldsNames:Array;

        public function performInjections(facade:FabricationFacade):void
        {
            injectionFieldsNames = ( new DependencyInjector(facade, this) ).inject();
        }
    }
}