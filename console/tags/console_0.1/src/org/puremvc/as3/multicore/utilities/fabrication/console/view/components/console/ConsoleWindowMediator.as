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
package org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console {
    import flash.events.Event;

    import mx.controls.CheckBox;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.ConsoleWindowNotifications;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.constants.CONSOLE_TO_FRONT;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class ConsoleWindowMediator extends FlexMediator {


        public function ConsoleWindowMediator(name:String, viewComponent:ConsoleWindow)
        {

            super(name, viewComponent);

        }


        override public function onRegister():void
        {
            active = false;
            view.open();
            super.onRegister();
        }

        public function set active(value:Boolean):void
        {

            view.visible = value;

        }

        public function get active():Boolean
        {

            return view.visible;
        }


        override public function onRemove():void
        {
            removeReaction(reactToViewClosing);
            view.close();
            super.onRemove();
        }

        public function reactToViewClosing(event:Event):void
        {

            event.preventDefault();
            active = false;
            sendNotification(ConsoleWindowNotifications.CONSOLE_CLOSE, mediatorName);


        }


        public function respondToCONSOLE_TO_FRONT(notification:INotification):void
        {

            var someMediatorName:String = notification.getBody() as String;
            if (someMediatorName != mediatorName) {

                alwaysInFrontSwitch.selected = false;

            }

        }

        CONSOLE_TO_FRONT function processNotification(notification:INotification):void
        {

            var someMediatorName:String = notification.getBody() as String;
            if (someMediatorName != mediatorName) {

                alwaysInFrontSwitch.selected = false;

            }

        }


        public function reactToAlwaysInFrontSwitchChange(event:Event):void
        {
            view.alwaysInFront = ( event.target as CheckBox ).selected;
            sendNotification(CONSOLE_TO_FRONT, mediatorName);
        }

        public function get alwaysInFrontSwitch():CheckBox
        {

            return view.alwaysInFrontOfSwitch;

        }

        public function get view():ConsoleWindow
        {
            return viewComponent as ConsoleWindow;
        }


    }
}