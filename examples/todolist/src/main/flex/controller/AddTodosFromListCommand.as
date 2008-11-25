package controller {
	import vo.TodoItem;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.undoable.UndoableMacroCommand;
	
	import mx.utils.StringUtil;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class AddTodosFromListCommand extends UndoableMacroCommand {
		
		override public function initializeUndoableCommand(note:INotification):void {
			var source:String = note.getBody() as String;
			var reLine:RegExp = /\r+|\n+/gim;
			var reComma:RegExp = /([^,]*\s[.]*[^,]*),*/gim;
			var res:Array = source.split(reLine);
			var splitOnLines:Boolean = res.length > 1;
			
			if (!splitOnLines) {
				res = source.split(reComma);
			}
			
			if (res.length > 1) {
				var n:int = res.length;
				var item:String;
				for (var i:int = 0; i < n; i++) {
					item = res[i];
					item = StringUtil.trim(item);
					
					if (splitOnLines) {
						var resLine:Array = item.split(reComma);
						var m:int = resLine.length;
						for (var j:int = 0; j < m; j++) {
							item = resLine[j];
							item = StringUtil.trim(item);
							
							if (item != "") {
								addSubCommand(AddTodoCommand, new TodoItem(item));
							}									
						}
					} else if (item != "") {
						addSubCommand(AddTodoCommand, new TodoItem(item));
					}
				}
			} else {
				addSubCommand(AddTodoCommand, new TodoItem(source));
			}			
		}
		
	}
}
