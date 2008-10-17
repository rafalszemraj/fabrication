package shell.model {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;	
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;	
	
	/**
	 * @author Darshan Sawardekar
	 */
	public class CounterProxy extends FabricationProxy {

		static public const NAME:String = "CounterProxy";
		static public const COUNT_CHANGED:String = "countChanged";
		
		public function CounterProxy(name:String = NAME, initialCount:int = 0) {
			super(name, initialCount);
		}
		
		public function get count():int {
			return data as int;
		}
		
		public function increment(stepSize:int = 1):void {
			changeCount(count + stepSize);
		}
		
		public function decrement(stepSize:int = 1):void {
			changeCount(count - stepSize);
		}
		
		public function changeCount(newCount:int):void {
			if (count != newCount) {
				setData(newCount);
				sendNotification(COUNT_CHANGED, newCount);
			}
		}
		
	}
}
