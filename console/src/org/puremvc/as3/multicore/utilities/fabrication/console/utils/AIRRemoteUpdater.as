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
package org.puremvc.as3.multicore.utilities.fabrication.console.utils {
    import air.update.ApplicationUpdater;
    import air.update.events.StatusUpdateErrorEvent;
    import air.update.events.StatusUpdateEvent;
    import air.update.events.UpdateEvent;

    import flash.events.EventDispatcher;
    import flash.events.ProgressEvent;

    public class AIRRemoteUpdater extends EventDispatcher {


        private var _au:ApplicationUpdater;
        private var _updateURL:String;

        public function AIRRemoteUpdater(updateURL:String)
        {
            _updateURL = updateURL;
            _au = new ApplicationUpdater();
        }

        public function update():void
        {

            _au.updateURL = _updateURL;
            _au.addEventListener(UpdateEvent.INITIALIZED, updaterInitialized);
            _au.addEventListener(StatusUpdateEvent.UPDATE_STATUS, updateStatusHandler);
            _au.addEventListener(ProgressEvent.PROGRESS, updateProgressHandler);
            _au.addEventListener(StatusUpdateErrorEvent.UPDATE_ERROR, updateErrorHandler);

            _au.initialize();

        }

        private function updateErrorHandler(event:StatusUpdateErrorEvent):void
        {
            event.preventDefault();
        }


        public function downloadUpdate():void
        {

            _au.downloadUpdate();
            
        }

        private function updateProgressHandler(event:ProgressEvent):void
        {
            dispatchEvent(event);
        }


        private function updaterInitialized(event:UpdateEvent):void
        {
            _au.checkNow();
            dispatchEvent(event);
        }

        private function updateStatusHandler(event:StatusUpdateEvent):void
        {
            event.preventDefault();
            if (event.version != "")
                dispatchEvent(event);
        }


        public function get currentVersion():String
        {
            return _au.currentVersion;
        }

        public function get previousVersion():String
        {
            return _au.previousVersion;
        }
    }
}