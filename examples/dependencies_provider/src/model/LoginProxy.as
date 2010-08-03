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
    import mx.controls.Alert;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;

    public class LoginProxy extends FabricationProxy {


        static public const NAME:String = "LoginProxy";


        [Inject("loginData")]
        public var loginData:Array;

        public function LoginProxy()
        {
            super(NAME);
        }


        public function login( login:String, pass:String ):void {

            var correct:Boolean = false;
            for each( var data:Object in loginData ) {


                var d_login:String = data.login;
                var d_pass:String = data.pass;

                if( login.toLowerCase() == d_login.toLowerCase() && pass.toLowerCase() == d_pass.toLowerCase() ) {


                    Alert.show( "login correct", "", Alert.OK );
                    correct = true;
                    break;


                }


            }

            if( !correct ) {
                
                    Alert.show( "login incorrect", "", Alert.OK );

            }


        }
    }
}