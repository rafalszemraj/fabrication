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
    import flash.utils.ByteArray;

    import org.puremvc.as3.multicore.patterns.observer.Notification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.INSPECT_OBJECT;

    public class InspectObjectNotification extends Notification {


        public var object:Object;
        public var objectName:String;

        public function InspectObjectNotification( objectBytes:ByteArray, objectName:String)
        {
            super(INSPECT_OBJECT);
            objectBytes.uncompress();
            objectBytes.position = 0;
            object = objectBytes.readObject() as Object;
            this.objectName = objectName;

        }
    }
}