package model {
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;	
	
	/**
	 * @author Darshan Sawardekar
	 */
	public class HeadingProxy extends Proxy {
		
		static public const NAME:String = "HeadingProxy";
		static public const HEADING_CHANGED:String = "headingChanged";
		
		public function HeadingProxy(heading:String = "") {
			super(NAME, heading);
		}
		
		public function get heading():String {
			return data as String;
		}
		
		public function changeHeading(newHeading:String):void {
			if (heading != newHeading) {
				setData(newHeading);
				sendNotification(HEADING_CHANGED, newHeading);				
			}
		}
		
	}
}
