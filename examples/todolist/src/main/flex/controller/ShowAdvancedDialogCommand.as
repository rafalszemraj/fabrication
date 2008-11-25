package controller {
	import view.AdvancedInputMediator;
	import view.components.AdvancedInput;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.command.SimpleFabricationCommand;
	
	import mx.core.Application;
	import mx.core.UIComponent;
	import mx.managers.PopUpManager;
	
	import flash.display.Stage;	

	/**
	 * @author Darshan Sawardekar
	 */
	public class ShowAdvancedDialogCommand extends SimpleFabricationCommand {
		
		override public function execute(note:INotification):void {
			var advancedInput:AdvancedInput = PopUpManager.createPopUp(
				fabrication as UIComponent, AdvancedInput, true
			) as AdvancedInput;
			
			var stage:Stage = (fabrication as Application).stage;
			
			advancedInput.x = stage.stageWidth/2 - advancedInput.width/2;
			advancedInput.y = stage.stageHeight/2 - advancedInput.height/2;
			
			registerMediator(new AdvancedInputMediator(advancedInput));
		}
		
	}
}
