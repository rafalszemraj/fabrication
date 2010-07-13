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
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    import spark.components.TextArea;

    public class TextAreaMediator extends FlexMediator {

        static public const NAME:String = "TextAreaMediator";

        public function TextAreaMediator(viewComponent:TextArea)
        {
            super(NAME, viewComponent);
        }

        public function respondToNotification(notification:INotification):void
        {
            component.appendText( "respond to note.\n" );
        }

        public function get component():TextArea
        {
            return viewComponent as TextArea;
        }

    }
}