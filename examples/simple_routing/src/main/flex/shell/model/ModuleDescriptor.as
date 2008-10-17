package shell.model {
	import mx.utils.UIDUtil;	
	
	/**
	 * @author Darshan Sawardekar
	 */
	public class ModuleDescriptor implements IListElement {
		
		public var url:String;
		private var elementID:String;
		
		public function ModuleDescriptor(url:String) {
			this.url = url;
			elementID = UIDUtil.createUID();
		}
		
		public function getElementID():String {
			return elementID;
		}
		
	}
}
