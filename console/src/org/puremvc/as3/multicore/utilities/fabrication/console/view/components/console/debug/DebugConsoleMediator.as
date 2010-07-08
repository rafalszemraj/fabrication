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
package org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.debug {
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.LOG_FRAMEWORK_MESSAGE;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.ConsoleWindowMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.logging.LogLevel;

    public class DebugConsoleMediator extends ConsoleWindowMediator {

        static public const NAME:String = "DebugConsoleMediator";

        public function DebugConsoleMediator(viewComponent:DebugConsole)
        {
            super(NAME, viewComponent);
        }


        public function respondToLOG_FRAMEWORK_MESSAGE( notification:INotification ):void {

            var message:String = "" + notification.getBody().message;
            var logLevel:LogLevel = notification.getBody().logLevel;
            debugConsole.debug(message, logLevel);

        }

        LOG_FRAMEWORK_MESSAGE function processNotification(notification:INotification):void
        {

            var message:String = "" + notification.getBody().message;
            var logLevel:LogLevel = notification.getBody().logLevel;
            debugConsole.debug(message, logLevel);
        }

        public function get debugConsole():DebugConsole
        {


            return view as DebugConsole;
        }

//        override protected function invokeNamespaceNotificationHandler(namespace:Namespace, note:INotification):void
//        {
//            ( namespace::processNotification ).apply(this, [ note ]);
//        }
    }
}