package org.puremvc.as3.multicore.utilities.fabrication.services{
    import flash.events.IEventDispatcher;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.facade.FabricationFacade;

    public interface IFabricationService extends IEventDispatcher {

        function performInjections( facade:FabricationFacade ):void;

    }
}