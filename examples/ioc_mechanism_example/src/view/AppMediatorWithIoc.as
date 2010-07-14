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

package view{
    import flash.events.MouseEvent;

    import model.IReportProxy;
    import model.ReportProxyOne;

    import notifications.Notifications;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class AppMediatorWithIoc extends FlexMediator {

        static public const NAME:String = "AppMediatorWithIoc";


        // try to change 'name' attribute of metatag, to 'ReportProxyOne'
        // this way you can change injected proxy by simple changing a string
        // in one place in mediator

        [InjectProxy(name="ReportProxyTwo")]
        public var reportProxy:IReportProxy;

        public function AppMediatorWithIoc(viewComponent:IoCMechanismExample)
        {

            super(NAME, viewComponent);
        }

        public function get compoment():IoCMechanismExample
        {
            return viewComponent as IoCMechanismExample;
        }

        public function reactToTriggerTwo$CLICK(event:MouseEvent):void
        {

            reportProxy.update();
            sendNotification( Notifications.MAKE_REPORT, reportProxy.createReport() );

        }

        public function displayReport( report:String ):void {

            compoment.text2.appendText( "IoC mediator : " + report + "\n" );

        }


    }
}