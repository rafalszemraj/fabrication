/**
 * Copyright (C) 2008 Darshan Sawardekar.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.puremvc.as3.multicore.utilities.fabrication.addons {
    import flash.events.Event;
    import flash.events.IEventDispatcher;

    import mx.core.IVisualElement;

    import mx.core.UIComponent;

    import mx.events.FlexEvent;
    import mx.events.ModuleEvent;
    import mx.modules.IModule;
    import mx.modules.IModuleInfo;
    import mx.modules.ModuleManager;

    import org.flexunit.async.Async;

    /**
     * @author Darshan Sawardekar
     */
    public class ModuleAwareTestCase extends BaseTestCase {

        protected var modulesInfoCache:Array = new Array();
        protected var timeoutMS:int = 30000;
        public var currentModule:IModule;
        protected var moduleUrl:String;


        protected function loadModule():void
        {
            var moduleInfo:IModuleInfo = ModuleManager.getModule(moduleUrl);
            modulesInfoCache.push(moduleInfo);
            Async.handleEvent(this, moduleInfo, ModuleEvent.READY, moduleInitializeAsyncHandler, timeoutMS);
            moduleInfo.load();
        }

        protected function moduleInitializeAsyncHandler(event:ModuleEvent, passThroughData:Object = null):void
        {

            var moduleInstance:IModule = createModule(event.module);
            assertNotNull(moduleInstance);
            Async.handleEvent( this, moduleInstance as IEventDispatcher, FlexEvent.INITIALIZE, moduleReadyAsyncHandler );
            addModule(moduleInstance);
        }

        protected function moduleReadyAsyncHandler(event:Event, passThroughData:Object = null):void
        {

        }

        private function createModule(moduleInfo:IModuleInfo):IModule
        {
            var moduleInstance:Object = moduleInfo.factory.create();
            return moduleInstance as IModule;
        }

        private function addModule(module:IModule):void
        {
            try {

                if (module is IVisualElement)
                {
                    TestSparkContainer.getInstance().add( module as UIComponent);
                }
                else
                {
                    TestContainer.getInstance().add(module as UIComponent);
                }
            }
            catch(e:Error) {

                TestSparkContainer.getInstance().add( module as UIComponent);
            }
        }
    }
}
