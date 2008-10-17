package view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
	
	import view.components.Editor;
	import view.components.Heading;
	import view.components.UndoNav;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class SimpleUndoDemoMediator extends FlexMediator {
		
		static public const NAME:String = "SimpleUndoDemoMediator";
		
		public function SimpleUndoDemoMediator(viewComponent:SimpleUndoDemo) {
			super(NAME, viewComponent);
		}
		
		public function get application():SimpleUndoDemo {
			return viewComponent as SimpleUndoDemo;
		}
		
		public function get heading():Heading {
			return application.heading as Heading;
		}
		
		public function get undoNav():UndoNav {
			return application.undoNav as UndoNav;
		}
		
		public function get editor():Editor {
			return application.editor as Editor;
		}
		
		override public function onRegister():void {
			registerMediator(new HeadingMediator(heading));
			registerMediator(new UndoNavMediator(undoNav));
			registerMediator(new EditorMediator(editor));
		}
		
	}
}
