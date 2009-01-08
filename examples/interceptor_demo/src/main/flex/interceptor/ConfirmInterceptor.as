package interceptor {
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.interceptor.AbstractInterceptor;
	
	import com.hexagonstar.util.debug.Debug;
	
	import trace;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class ConfirmInterceptor extends AbstractInterceptor {
		
		override public function intercept():void {
			Alert.yesLabel = "Ok";
			Alert.cancelLabel = "Cancel";
			Alert.show("Are you sure?", "Confirm", Alert.OK | Alert.CANCEL, null, closeListener);
		}
		
		private function closeListener(event:CloseEvent):void {
			if (event.detail == Alert.OK) {
				proceed();
			} else {
				skip();
			}
		}
	}
}
