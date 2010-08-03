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

package view {
    import flash.events.MouseEvent;

    import model.LoginProxy;

    import mx.collections.ArrayCollection;

    import notifications.LOGINS_READY;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class RPCExampleMediator extends FlexMediator {

        static public const NAME:String = "RPCExampleMediator";

        [InjectProxy]
        public var loginProxy:LoginProxy;

        public function RPCExampleMediator(viewComponent:RPCExample)
        {

            super(NAME, viewComponent);
        }


        public override function onRegister():void
        {
            super.onRegister();
        }

        public function get component():RPCExample
        {
            return viewComponent as RPCExample;
        }

        public function reactToSubmit$CLICK(event:MouseEvent):void
        {
            component.logins.dataProvider = null;
            loginProxy.getLogins();

        }

        LOGINS_READY function processNotification(notification:INotification):void
        {

            var loginsData:Array = notification.getBody() as Array;
            component.logins.dataProvider = new ArrayCollection( loginsData );

        }

        

    }
}