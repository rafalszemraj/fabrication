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
package org.puremvc.as3.multicore.utilities.fabrication.console.view {
    import flash.desktop.DockIcon;
    import flash.desktop.NativeApplication;
    import flash.desktop.NotificationType;
    import flash.desktop.SystemTrayIcon;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.NativeMenu;
    import flash.display.NativeMenuItem;
    import flash.display.NativeWindow;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.media.Sound;
    import flash.net.SharedObject;
    import flash.utils.setTimeout;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.notifications.ConsoleLogNotifications;
    import org.puremvc.as3.multicore.utilities.fabrication.console.utils.Icons;
    import org.puremvc.as3.multicore.utilities.fabrication.console.utils.Sounds;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.UpdateWindow;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.UpdateWindowMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.base.ImageButton;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.debug.DebugConsoleMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.flow.ActionConsoleMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.log.LogConsoleMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class FabricationConsoleMediator extends FlexMediator {

        static public const NAME:String = "FabricationConsoleMediator";


        [InjectMediator]
        public var debugConsoleMediator:DebugConsoleMediator;

        [InjectMediator]
        public var flowConsoleMediator:ActionConsoleMediator;

        [InjectMediator]
        public var logConsoleMediator:LogConsoleMediator;


        private var _activeNotificationMode:Boolean = true;

        public function FabricationConsoleMediator(viewComponent:FabricationConsole)
        {

            super(NAME, viewComponent);
        }


        override public function onRegister():void
        {
            super.onRegister();
            setupMenu();
            checkUpdate();

            debugConsoleMediator = retrieveMediator(DebugConsoleMediator.NAME) as DebugConsoleMediator;
        }

        private function checkUpdate():void
        {
            var uw:UpdateWindow = new UpdateWindow();
            registerMediator(new UpdateWindowMediator(uw));
        }


        public function respondToLOG(notification:INotification):void
        {

            var nativeApp:NativeApplication = NativeApplication.nativeApplication;
            switch (notification.getBody()) {


                case ConsoleLogNotifications.LOG_FRAMEWORK_MESSAGE :

                    var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
                    var trayIcon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;


                    if (!debugConsoleMediator.active && _activeNotificationMode) {

                        view.debugConsoleButton.notify();
                        _activeNotificationMode = false;

                        if (NativeWindow.supportsNotification) {


                            nativeApp.activeWindow.notifyUser(NotificationType.CRITICAL);

                        }


                        if (dockIcon) dockIcon.bounce(NotificationType.CRITICAL);
                        var snmi:NativeMenuItem = dockIcon ? dockIcon.menu.getItemByName("soundsMenuItem") : trayIcon.menu.getItemByName("soundsMenuItem");
                        if (snmi.checked) {

                            ( new Sounds.alert() as Sound ).play();

                        }


                    }


            }

        }

        public function respondToCONSOLE_CLOSE(notification:INotification):void
        {

            switch (notification.getBody()) {


                case DebugConsoleMediator.NAME :

                    view.debugConsoleButton.enabled = true;
                    _activeNotificationMode = true;
                    break;

                case ActionConsoleMediator.NAME :

                    view.flowConsoleButton.enabled = true;

                    break;

                case LogConsoleMediator.NAME :

                    view.logConsoleButton.enabled = true;

                    break;


            }

        }

        public function reactToViewMouseDown(event:MouseEvent):void
        {

            NativeApplication.nativeApplication.activeWindow.startMove();
            var allWindows:Array = NativeApplication.nativeApplication.openedWindows;
            for each(var window:NativeWindow in allWindows) {


                window.orderToFront();

            }

        }

        public function reactToNativeAppExiting(event:Event):void
        {

            event.preventDefault();
            setTimeout(NativeApplication.nativeApplication.exit, 1);

        }


        public function reactToViewClosing(event:Event):void
        {

            removeMediator(debugConsoleMediator.getMediatorName());
            removeMediator(flowConsoleMediator.getMediatorName());
            removeMediator(logConsoleMediator.getMediatorName());

        }


        public function reactToViewClick(event:MouseEvent):void
        {

            switch (event.target) {


                case view.debugConsoleButton :

                    debugConsoleMediator.active = true;
                    manageClickedButton(view.debugConsoleButton);

                    break;

                case view.flowConsoleButton :

                    flowConsoleMediator.active = true;
                    manageClickedButton(view.flowConsoleButton);

                    break;

                case view.logConsoleButton :

                    logConsoleMediator.active = true;
                    manageClickedButton(view.logConsoleButton);

                    break;
                case view.powerButton :

                    NativeApplication.nativeApplication.exit();

            }

        }

        public function get nativeApp():NativeApplication
        {

            return view.nativeApplication;

        }

        public function get view():FabricationConsole
        {
            return viewComponent as FabricationConsole;
        }


        //        override protected function get notificationInterestsToFulfill():Array
        //        {
        //            return [ ConsoleWindowNotifications.CONSOLE_CLOSE ];
        //        }

        private function manageClickedButton(button:ImageButton):void
        {
            button.enabled = false;
            button.clearNotification();
        }

        private function setupMenu():void
        {
            var dockIcon:DockIcon = NativeApplication.nativeApplication.icon as DockIcon;
            var trayIcon:SystemTrayIcon = NativeApplication.nativeApplication.icon as SystemTrayIcon;

            if (NativeApplication.supportsSystemTrayIcon) {

                var systemTrayIcon_16:Bitmap = new Icons.systemTrayIcon_16();

                var icon:BitmapData = new BitmapData(systemTrayIcon_16.width, systemTrayIcon_16.height, true, 0x00000000);
                icon.draw(systemTrayIcon_16);

                trayIcon.bitmaps = [ icon ];

            }


            var nMenu:NativeMenu = new NativeMenu();
            var soundsMenuItem:NativeMenuItem = new NativeMenuItem("enable sounds");
            soundsMenuItem.name = "soundsMenuItem";

            var so:SharedObject = SharedObject.getLocal("org.puremvc.as3.multicore.utilities.fabrication.FabricationConsole");
            soundsMenuItem.checked = so.data.soundsEnabled;

            soundsMenuItem.addEventListener(Event.SELECT, soundsMenuItemSelectHandler);
            nMenu.addItem(soundsMenuItem);
            if (dockIcon) dockIcon.menu = nMenu;
            if (trayIcon) trayIcon.menu = nMenu;
        }

        private function soundsMenuItemSelectHandler(event:Event):void
        {
            var snmi:NativeMenuItem = event.target as NativeMenuItem;
            snmi.checked = !snmi.checked;

            var so:SharedObject = SharedObject.getLocal("org.puremvc.as3.multicore.utilities.fabrication.FabricationConsole");
            so.data.soundsEnabled = snmi.checked;
            so.flush();
        }

    }
}