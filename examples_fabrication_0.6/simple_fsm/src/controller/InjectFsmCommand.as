/**
 * Copyright (C) 2009 Darshan Sawardekar.
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
 
package controller {
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	import org.puremvc.as3.multicore.utilities.statemachine.FSMInjector;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class InjectFsmCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var fsm:XML = 
			<fsm initial={SimpleFsmConstants.STATE_RED}>
				<state name={SimpleFsmConstants.STATE_RED}>
					<transition action={SimpleFsmConstants.TO_ORANGE} target={SimpleFsmConstants.STATE_ORANGE} />
					<transition action={SimpleFsmConstants.TO_GREEN} target={SimpleFsmConstants.STATE_GREEN} />
				</state>
				<state name={SimpleFsmConstants.STATE_ORANGE}>
					<transition action={SimpleFsmConstants.TO_RED} target={SimpleFsmConstants.STATE_RED} />
					<transition action={SimpleFsmConstants.TO_GREEN} target={SimpleFsmConstants.STATE_GREEN} />
				</state>
				<state name={SimpleFsmConstants.STATE_GREEN}>
					<transition action={SimpleFsmConstants.TO_RED} target={SimpleFsmConstants.STATE_RED} />
					<transition action={SimpleFsmConstants.TO_ORANGE} target={SimpleFsmConstants.STATE_ORANGE} />
				</state>
			</fsm>;
		
         var injector:FSMInjector = new FSMInjector(fsm);
         injector.initializeNotifier(multitonKey);
         injector.inject();
		}
		
	}
}
