package simplemodule.view {
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;	
	
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.utilities.fabrication.interfaces.IRouterAwareModule;
	
	import common.FabricationRoutingDemoConstants;
	
	import shell.FabricationRoutingDemoShellConstants;
	
	import simplemodule.view.components.BackgroundCanvas;		

	/**
	 * @author Darshan Sawardekar
	 */
	public class BackgroundCanvasMediator extends FlexMediator {

		static public const NAME:String = "BackgroundCanvasMediator";
		
		private var color:int;
		private var alpha:Number;
		
		public function BackgroundCanvasMediator(viewComponent:BackgroundCanvas) {
			super(NAME, viewComponent);
		}
		
		public function get backgroundCanvas():BackgroundCanvas {
			return viewComponent as BackgroundCanvas;
		}
		
		override public function onRegister():void {
			color = Math.random() * 0xFFFFFF;
			alpha = Math.random();
			
			drawBackground(color, alpha);
			
			backgroundCanvas.addEventListener(MouseEvent.MOUSE_OVER, backgroundMouseOverListener);
			backgroundCanvas.addEventListener(MouseEvent.MOUSE_OUT, backgroundMouseOutListener);
			backgroundCanvas.addEventListener(MouseEvent.CLICK, backgroundMouseClickListener);
			
			backgroundCanvas.toolTip = applicationAddress.getClassName() + "/" + applicationAddress.getInstanceName();
		}
		
		/*
		override public function listNotificationInterests():Array {
			return [shellCountChangedNotification,
					 moduleCountChangedNotification,
					 FabricationRoutingDemoConstants.SELECTED_MODULE_CHANGED];
		}
		
		override public function handleNotification(note:INotification):void {
			var noteName:String = note.getName();
			if (noteName == FabricationRoutingDemoConstants.SELECTED_MODULE_CHANGED) {
				var module:IRouterAwareModule = note.getBody() as IRouterAwareModule;
				backgroundCanvas.graphics.clear();
				
				if (module == fabrication) {
					drawBackground(color, alpha);
					drawBorder();
				} else {
					drawBackground(color, alpha);
				}
			}
		} 
		/* */
		
		public function respondToSelectedModuleChanged(note:INotification):void {
			var noteName:String = note.getName();
			if (noteName == FabricationRoutingDemoConstants.SELECTED_MODULE_CHANGED) {
				var module:IRouterAwareModule = note.getBody() as IRouterAwareModule;
				backgroundCanvas.graphics.clear();
				
				if (module == fabrication) {
					drawBackground(color, alpha);
					drawBorder();
				} else {
					drawBackground(color, alpha);
				}
			}
		}
		
		private function drawBackground(color:int, alpha:Number):void {
			var graphics:Graphics = backgroundCanvas.graphics;
			graphics.beginFill(color, alpha);
			graphics.drawRect(0, 0, backgroundCanvas.width, backgroundCanvas.height);
			graphics.endFill();
		}		
		
		private function drawBorder(color:int = 0, alpha:Number = 0.5, thickness:int = 30):void {
			var graphics:Graphics = backgroundCanvas.graphics;
			var w:int = backgroundCanvas.width;
			var h:int = backgroundCanvas.height;
			
			graphics.beginFill(color, alpha);
			drawCropRect(graphics, 0, 0, w, h, thickness, thickness, -thickness, -thickness);
			graphics.endFill();
		}
		
		private function drawCropRect(mc:Graphics, x:Number, y:Number, width:Number, height:Number, x0:Number, y0:Number, x1:Number, y1:Number):void {
			var xDirSign:Number = width/Math.abs (width);
			var yDirSign:Number = height/Math.abs (height);
	
			var xMin:Number = x0 < 0 ? x + x0 : x;
			var yMin:Number = y0 < 0 ? y + y0 : y;
			var xMax:Number = x1 > 0 ? width + x1* (xDirSign) : width;
			var yMax:Number = y1 > 0 ? height + y1 * (yDirSign) : height;
	
			var xMin2:Number = x0 < 0 ? x : x + x0*(xDirSign);
			var yMin2:Number = y0 < 0 ? y : y + y0*(yDirSign);
			var xMax2:Number = x1 > 0 ? width : width + x1*(xDirSign);
			var yMax2:Number = y1 > 0 ? height : height + y1*(yDirSign);
	
			mc.moveTo (xMin, yMin);
			mc.lineTo (xMax, yMin);
			mc.lineTo (xMax, yMax);
			mc.lineTo (xMin, yMax);
			mc.lineTo (xMin, yMin);
	
			mc.moveTo (xMin2, yMin2);
			mc.lineTo (xMax2, yMin2);
			mc.lineTo (xMax2, yMax2);
			mc.lineTo (xMin2, yMax2);
			mc.lineTo (xMin2, yMin2);
		}
		
		private function backgroundMouseOverListener(event:MouseEvent):void {
			backgroundCanvas.alpha = 0.5;
		}
		
		private function backgroundMouseOutListener(event:MouseEvent):void {
			backgroundCanvas.alpha = 1;
		}
		
		private function backgroundMouseClickListener(event:MouseEvent):void {
			routeNotification(FabricationRoutingDemoShellConstants.SELECT_MODULE, fabrication);
		}
		
	}
}
