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

package model {
    import mx.rpc.events.ResultEvent;

    import notifications.LOGINS_READY;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationRemoteProxy;

    import services.ILoginService;

    public class LoginProxy extends FabricationRemoteProxy {


        static public const NAME:String = "LoginProxy";


        [InjectService("loginService")]
        public var loginService:ILoginService;

        public function LoginProxy()
        {
            super(NAME);
        }

        public function getLogins():void {

            excuteServiceCall( loginService.getLogins(), onLoginsComplete, onLoginsFault );

        }

        private function onLoginsFault( fault:Object ):void
        {
        }

        private function onLoginsComplete( result:Object ):void
        {
            sendNotification( LOGINS_READY, ( result as ResultEvent ).result );

        }



    }
}