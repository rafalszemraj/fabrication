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
package org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.log {
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.InspectObjectNotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.LogMessageNotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.INSPECT_OBJECT;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.LOG_MESSAGE;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.ConsoleWindowMediator;

    public class LogConsoleMediator extends ConsoleWindowMediator {

        static public const NAME:String = "LogConsoleMediator";

        public function LogConsoleMediator(viewComponent:LogConsole)
        {
            super(NAME, viewComponent);
        }


        public function respondToLOG_MESSAGE( notification:LogMessageNotification ):void {

            debugConsole.logMessage(notification.message, notification.logLevel);

        }

        public function respondToINSPECT_OBJECT( notification:InspectObjectNotification ):void {

           debugConsole.inspectObject(notification.object, notification.objectName); 

        }

        LOG_MESSAGE function processNotification(notification:LogMessageNotification):void
        {
            debugConsole.logMessage(notification.message, notification.logLevel);
        }


        INSPECT_OBJECT function processNotification(notification:InspectObjectNotification):void
        {
            debugConsole.inspectObject(notification.object, notification.objectName);
        }

        public function get debugConsole():LogConsole
        {

            return view as LogConsole;
        }


        override protected function invokeNotificationHandler(name:String, note:INotification):void
        {
            super.invokeNotificationHandler(name, note);
        }

        //        override protected function invokeNamespaceNotificationHandler(namespace:Namespace, note:INotification):void
//        {
//            ( namespace::processNotification ).apply(this, [ note ]);
//        }
    }
}