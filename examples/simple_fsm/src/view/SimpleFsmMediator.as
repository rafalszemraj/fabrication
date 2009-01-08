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
 
package view {
	import mx.containers.Canvas;
	import mx.controls.ButtonBar;
	import mx.events.ItemClickEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	import org.puremvc.as3.multicore.utilities.statemachine.State;
	import org.puremvc.as3.multicore.utilities.statemachine.StateMachine;
	
	import com.hexagonstar.util.debug.Debug;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class SimpleFsmMediator extends FlexMediator {
		
		static public const NAME:String = "SimpleFsmMediator";
		
		static public const colors:Object = {
			stateRed:0xFF0000,
			stateOrange:0xFF9900,
			stateGreen:0x00FF00
		};
		
		public function SimpleFsmMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get application():SimpleFsm {
			return viewComponent as SimpleFsm;
		}
		
		public function get signalButtonBar():ButtonBar {
			return application.signalButtonBar as ButtonBar;
		}
		
		public function get signalCanvas():Canvas {
			return application.signalCanvas as Canvas;
		}
		
		public function reactToSignalButtonBarItemClick(event:ItemClickEvent):void {
			var toSignal:String = "to" + event.label;
			sendNotification(StateMachine.ACTION, null, toSignal);
		}
		
		public function respondToStateChanged(note:INotification):void {
			var state:State = note.getBody() as State;
			var color:int = colors[state.name];
			
			signalCanvas.setStyle("backgroundColor", color);
		}
		
		public function respondToStateAction(note:INotification):void {
			//Debug.trace("respondToStateAction");
		}
		
		public function respondToStateCancel(note:INotification):void {
			//Debug.trace("respondToStateCancel");
		}
	}
}