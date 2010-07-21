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
package org.puremvc.as3.multicore.utilities.fabrication.console.notifications {
    import org.puremvc.as3.multicore.patterns.observer.Notification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.LOG_MESSAGE;
    import org.puremvc.as3.multicore.utilities.fabrication.logging.LogLevel;

    public class LogMessageNotification extends Notification {

        public var message:String;
        public var logLevel:LogLevel;

        public function LogMessageNotification(message:String, logLevelName:String)
        {
            super(LOG_MESSAGE);
            this.message = message;
            this.logLevel = LogLevel.fromLogLevelName(logLevelName);
        }
    }
}