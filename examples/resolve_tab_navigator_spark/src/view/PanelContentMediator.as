package view {
	import flash.utils.getTimer;
	
	import mx.containers.VBox;
	import mx.controls.Text;

    import mx.core.UIComponent;

    import org.puremvc.as3.multicore.utilities.fabrication.events.MediatorRegistrarEvent;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.resolver.Expression;

    import spark.components.SkinnableContainer;

    /**
	 * @author Darshan Sawardekar
	 */
	public class PanelContentMediator extends FlexMediator {
		
		static public const NAME:String = "PanelContentMediator";
		
		public function PanelContentMediator(viewComponent:Object) {
			super(NAME, viewComponent);
		}
		
		public function get content():UIComponent {
			return viewComponent as UIComponent;
		}
		
		public function get statusText():Text {

            var t:Text;
			t = content.getChildAt(0) as Text;
            if( !t )  {

                t = ( content as SkinnableContainer ).getElementAt( 0 ) as Text;

            }
            return t;
		}

		
		override public function onRegister():void {
			//content.setStyle("backgroundColor", Math.random() * 0xFFFFFF);
			statusText.text = "Panel content written by " + 
				"\r" + getMediatorName() + " after " + getTimer()/1000 + " from application start.";
		}


        override protected function registrationCompletedListener(event:MediatorRegistrarEvent):void
        {
            super.registrationCompletedListener(event);
            trace( "registration completed for " + getMediatorName() );
        }

        private function generateComponentName( vc:Object ):String {

            if( vc is UIComponent )
                return ( vc as UIComponent ).id;
            else {

                return ( vc as Expression ).source;
            }



        }
		
	}
}
