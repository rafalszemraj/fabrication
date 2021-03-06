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

    import notifictions.LOGIN;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class ApplicationMediator extends FlexMediator {

        static public const NAME:String = "ApplicationMediator";

        [InjectProxy]
        public var loginProxy:LoginProxy;

        public function ApplicationMediator(viewComponent:DependenciesProviderExample)
        {

            super(NAME, viewComponent);
        }

        public function get component():DependenciesProviderExample
        {
            return viewComponent as DependenciesProviderExample;
        }


        public override function onRegister():void
        {
            super.onRegister();
            var dp:ArrayCollection  = new ArrayCollection( loginProxy.loginData );
            component.properLogins.dataProvider  = dp;
        }

        public function reactToSubmit$CLICK(event:MouseEvent):void
        {

            sendNotification( LOGIN, { login:component.login, pass:component.pass } );

        }

    }
}