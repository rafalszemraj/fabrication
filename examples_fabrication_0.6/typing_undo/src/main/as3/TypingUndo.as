package {
	import controller.TypingUndoStartupCommand;
	
	import org.puremvc.as3.multicore.utilities.fabrication.components.FlashApplication;
	
	import flash.utils.getDefinitionByName;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class TypingUndo extends FlashApplication {

		override public function getStartupCommand():Class {
			return TypingUndoStartupCommand;
		}

		override public function getClassByName(classpath:String):Class {
			return getDefinitionByName(classpath) as Class;
		}
	}
}
