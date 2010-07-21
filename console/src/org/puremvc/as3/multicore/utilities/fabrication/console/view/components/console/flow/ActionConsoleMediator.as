/*
 * Copyright (C) 2009 Rafał Szemraj, ( http://szemraj.eu )
 *
 * Tequila, The Ministry Of Ideas Co. Ltd.
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
package org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.flow {

    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.Dictionary;

    import mx.core.UIComponent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.LOG_ACTION;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.base.ImageLinkRenderer;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.ConsoleWindowMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.flow.ActionConsole;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.property.PropertyConsole;
    import org.puremvc.as3.multicore.utilities.fabrication.logging.action.Action;

    public class ActionConsoleMediator extends ConsoleWindowMediator {

        static public const NAME:String = "ActionConsoleMediator";

        private var _propertyConsolas:Dictionary;

        public function ActionConsoleMediator(viewComponent:ActionConsole)
        {
            super(NAME, viewComponent);
            _propertyConsolas = new Dictionary(true);
        }


        override public function onRemove():void
        {
            destroyPropertyConsolas();
            super.onRemove();
        }

        LOG_ACTION function processNotification(notification:INotification):void
        {
            var action:Action = notification.getBody() as Action;
            flowConsole.actionsDataProvider.addItem(action);
        }

        override public function set active(value:Boolean):void
        {

            if (!value) {

                destroyPropertyConsolas();

            }
            super.active = value;
        }

        public function reactToFlowConsoleClick(event:MouseEvent):void
        {
            var eTarget:ImageLinkRenderer = event.target as ImageLinkRenderer;
            if (eTarget) {
                var action:Action = ( eTarget.data as Action);
                var eName:String = action.index + "_propertyConsole";
                if (_propertyConsolas[ eName ] == null) {

                    var propertyConsole:PropertyConsole = new PropertyConsole();
                    propertyConsole.name = action.index + "_propertyConsole";
                    propertyConsole.title = action.actorName;
                    propertyConsole.inspectObject(action.infoObject);
                    propertyConsole.addEventListener(Event.CLOSING, propertyConsoleClosingHandler);
                    propertyConsole.alwaysInFront = true;
                    propertyConsole.open(true);
                    _propertyConsolas[ eName ] = propertyConsole;
                }

                else {


                    ( _propertyConsolas[ eName ] as PropertyConsole ).focus();

                }
            }


        }

        public function reactToClearClick(event:MouseEvent):void
        {

            destroyPropertyConsolas();

        }


        public function get clear():UIComponent
        {

            return flowConsole.clear;

        }

        public function get flowConsole():ActionConsole
        {


            return view as ActionConsole;
        }

        public function destroyPropertyConsolas():void
        {

            for each(var console:PropertyConsole in _propertyConsolas) {

                if (console)
                    console.close();

            }
            _propertyConsolas = new Dictionary(true);

        }

        private function propertyConsoleClosingHandler(event:Event):void
        {
            var propertyConsole:PropertyConsole = event.target as PropertyConsole;
            _propertyConsolas[ ( propertyConsole ).name ] = null;
            propertyConsole.removeEventListener(event.type, propertyConsoleClosingHandler);


        }

//        override protected function invokeNamespaceNotificationHandler(namespace:Namespace, note:INotification):void
        //        {
        //            ( namespace::processNotification ).apply(this, [ note ]);
        //        }
    }
}