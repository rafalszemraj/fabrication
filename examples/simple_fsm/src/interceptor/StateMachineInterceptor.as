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
 
package interceptor {
	import org.puremvc.as3.multicore.patterns.observer.Notification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.interceptor.AbstractInterceptor;
	
	import com.hexagonstar.util.debug.Debug;
	
	import trace;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class StateMachineInterceptor extends AbstractInterceptor {
		
		override public function intercept():void {
			var name:String = notification.getName();
			var fsmRegExp:RegExp = /^StateMachine\/\w*\/(\w*)$/;
			var result:Object = fsmRegExp.exec(name);
			
			if (result != null) {
				var newName:String = result[1];
				newName = "state" + newName.substring(0, 1).toUpperCase() + newName.substring(1);
				
				sendNotification(newName, notification.getBody(), notification.getType());
			}
			
			proceed();
		}
		
	}
}
