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
package org.puremvc.as3.multicore.utilities.fabrication.console.view.components {
    import air.update.events.StatusUpdateEvent;

    import flash.events.MouseEvent;

    import mx.core.UIComponent;

    import org.puremvc.as3.multicore.utilities.fabrication.console.utils.AIRRemoteUpdater;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class UpdateWindowMediator extends FlexMediator {

        static public const NAME:String = "UpdateWindowMediator";

        public function UpdateWindowMediator(viewComponent:UpdateWindow)
        {

            super(NAME, viewComponent);

        }


        private var _airUpdater:AIRRemoteUpdater;

        override public function onRegister():void
        {
            super.onRegister();

            _airUpdater = new AIRRemoteUpdater("http://fabrication.googlecode.com/svn/console/trunk/src/update.xml");
            _airUpdater.addEventListener(StatusUpdateEvent.UPDATE_STATUS, onUpdateStatus);
            _airUpdater.update();

        }

        private function onUpdateStatus(event:StatusUpdateEvent):void
        {
            view.currentVersion = _airUpdater.currentVersion;
            view.newVersion = event.version;
            if (event.details.length)
                view.updateDetails = "" + event.details[0][1];

            view.open(true);
            view.orderToFront();
        }

        override public function onRemove():void
        {
            view.close();
            super.onRemove();

        }

        public function get view():UpdateWindow
        {
            return viewComponent as UpdateWindow;
        }


        public function reactToViewClick(event:MouseEvent):void
        {
            if (event.target == view.cancelButton)
                removeMediator(mediatorName);

            if (event.target == view.updateButton) {

                view.currentState = "update";
                view.progressEventSource = _airUpdater;
                _airUpdater.downloadUpdate();

            }

        }


        public function get cancelButton():UIComponent
        {

            return view.cancelButton;

        }

    }
}