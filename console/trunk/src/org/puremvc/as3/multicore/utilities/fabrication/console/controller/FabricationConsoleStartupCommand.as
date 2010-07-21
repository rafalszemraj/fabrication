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

package org.puremvc.as3.multicore.utilities.fabrication.console.controller {
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.console.model.ConsoleRecieverProxy;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.FabricationConsoleMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.debug.DebugConsole;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.debug.DebugConsoleMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.flow.ActionConsole;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.flow.ActionConsoleMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.log.LogConsole;
    import org.puremvc.as3.multicore.utilities.fabrication.console.view.components.console.log.LogConsoleMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;

    public class FabricationConsoleStartupCommand extends SimpleFabricationCommand {


        public override function execute(notification:INotification):void
        {
            super.execute(notification);
            registerProxy(new ConsoleRecieverProxy()) as ConsoleRecieverProxy;


            var ec:DebugConsole = new DebugConsole();
            registerMediator(new DebugConsoleMediator(ec));

            var fc:ActionConsole = new ActionConsole();
            registerMediator(new ActionConsoleMediator(fc));

            var lc:LogConsole = new LogConsole();

            registerMediator(new LogConsoleMediator(lc));

            var app:FabricationConsole = notification.getBody() as FabricationConsole;
            registerMediator(new FabricationConsoleMediator(app));
        }
    }
}