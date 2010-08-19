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

    import org.puremvc.as3.multicore.utilities.fabrication.logging.Log;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class StateChangeReactionsMediator extends FlexMediator {

        static public const NAME:String = "StateChangeReactionsMediator";

        public function StateChangeReactionsMediator(viewComponent:StateChangeReactions)
        {

            super(NAME, viewComponent);
        }


        public function reactToDoRegistration$CLICK(notification:MouseEvent):void
        {
            component.currentState = "register";
        }

        public function reactToReturnToSigning$CLICK(event:MouseEvent):void
        {
            component.currentState = "signin";
        }



        public function get component():StateChangeReactions
        {
            return viewComponent as StateChangeReactions;
        }

    }
}