package model {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;			

	/**
	 * @author Darshan Sawardekar
	 */
	public class TextProxy extends FabricationProxy {
		
		static public const NAME:String = "TextProxy";
		static public const TEXT_CHANGED:String = "textChanged";
		
		public function TextProxy(text:String = "") {
			super(NAME, text);
		}
		
		public function get text():String {
			return data as String;
		}
		
		public function set text(_text:String):void {
			setData(_text);
			sendNotification(TEXT_CHANGED, _text);
		}
		
	}
}
