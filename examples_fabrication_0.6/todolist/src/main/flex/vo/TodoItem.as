package vo {

	/**
	 * @author Darshan Sawardekar
	 */
	[Bindable]
	public class TodoItem {
		
		public var name:String;
		
		public function TodoItem($name:String = null) {
			this.name = $name;
		}
		
	}
}
