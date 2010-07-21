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

package org.puremvc.as3.multicore.utilities.fabrication.console.model {
    import flash.utils.ByteArray;

    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.ConsoleLogNotifications;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.InspectObjectNotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.LogMessageNotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.LOG;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.LOG_ACTION;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.LOG_FRAMEWORK_MESSAGE;
    import org.puremvc.as3.multicore.utilities.fabrication.logging.LogLevel;
    import org.puremvc.as3.multicore.utilities.fabrication.logging.action.Action;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;

    public class ConsoleRecieverProxy extends FabricationProxy {

        static public const NAME:String = "ConsoleRecieverProxy";

        public function ConsoleRecieverProxy()
        {

            super(NAME);


        }


        public function logMessage(message:String, logLevelName:String):void
        {

            notifyObservers(new LogMessageNotification(message, logLevelName));

        }

        public function inspectObject(objectBytes:ByteArray, objectName:String):void
        {

            notifyObservers(new InspectObjectNotification(objectBytes, objectName));

        }

        public function logAction(action:Action):void
        {
            sendNotification(LOG_ACTION, action);
        }

        public function logFrameworkMessage(message:String, logLevelName:String):void
        {

            sendNotification(LOG_FRAMEWORK_MESSAGE, { message:message, logLevel:LogLevel.fromLogLevelName(logLevelName) });
            sendNotification(LOG, ConsoleLogNotifications.LOG_FRAMEWORK_MESSAGE);

        }

    }
}