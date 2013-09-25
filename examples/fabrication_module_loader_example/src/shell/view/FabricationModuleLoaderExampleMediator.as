/**
 * Copyright (C) 2010 Rafał Szemraj.
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

package shell.view {
    import flash.events.MouseEvent;

    import mx.core.IVisualElementContainer;
    import mx.events.ModuleEvent;
    import mx.utils.UIDUtil;

    import org.puremvc.as3.multicore.utilities.fabrication.components.FabricationModuleLoader;
    import org.puremvc.as3.multicore.utilities.fabrication.components.FlexModule;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    import spark.components.Application;

    /**
     * @author Rafał Szemraj
     */
    public class FabricationModuleLoaderExampleMediator extends FlexMediator {

        static public const NAME:String = "FabricationModuleLoaderExampleMediator";

        public function FabricationModuleLoaderExampleMediator(viewComponent:Application)
        {
            super(NAME, viewComponent);
        }


        public function reactToLoadButton$CLICK(evnet:MouseEvent):void
        {

            loadModule("SimpleModule.swf");
            viewComponent['loadButton'].enabled = viewComponent['unloadButton'].enabled = false;

        }

        public function reactToUnloadButton$CLICK(evnet:MouseEvent):void
        {

            unloadModule();

        }

        private function unloadModule():void
        {
            if (modulesContainer.numElements) {


                var module:FlexModule = modulesContainer.getElementAt(modulesContainer.numElements - 1) as FlexModule;
                modulesContainer.removeElement(module);
                module.dispose();

            }
            viewComponent['loadButton'].enabled = modulesContainer.numElements < 10;
            viewComponent['unloadButton'].enabled = modulesContainer.numElements > 0;


        }

        public function loadModule(moduleURL:String):void
        {

            var moduleLoader:FabricationModuleLoader = ( viewComponent as IModuleCreator ).createModuleLoader(applicationRouter, applicationAddress);
            moduleLoader.id = UIDUtil.createUID();
            moduleLoader.addEventListener(ModuleEvent.READY, moduleLoaderReadyHandler);

            moduleLoader.loadModule(moduleURL);


        }

        private function moduleLoaderReadyHandler(event:ModuleEvent):void
        {
            var moduleLoader:FabricationModuleLoader = event.target as FabricationModuleLoader;

            moduleLoader.removeEventListener(event.type, moduleLoaderReadyHandler);
            modulesContainer.addElement(moduleLoader.flexModule);
            viewComponent['loadButton'].enabled = modulesContainer.numElements < 10;
            viewComponent['unloadButton'].enabled = modulesContainer.numElements > 0;

        }


        private function get modulesContainer():IVisualElementContainer
        {

            return viewComponent['container'];

        }


    }
}
