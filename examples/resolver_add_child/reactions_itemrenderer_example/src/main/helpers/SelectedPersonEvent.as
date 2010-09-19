package main.helpers
{
    import flash.events.Event;

    public class SelectedPersonEvent extends Event
    {
        public static const SELECTED_PERSON:String = "selectedPerson";
        
        public var person:PersonVo;
        
        public function SelectedPersonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, person:PersonVo = null)
        {
            super(type, bubbles, cancelable);

            this.person = person;
        }


        override public function clone():Event
        {
            return super.clone();
        }
    }
}