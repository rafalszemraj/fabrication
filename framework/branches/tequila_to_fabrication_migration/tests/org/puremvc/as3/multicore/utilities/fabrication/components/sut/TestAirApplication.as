package org.puremvc.as3.multicore.utilities.fabrication.components.sut {
    import org.puremvc.as3.multicore.utilities.fabrication.addons.helpers.*;
    import org.puremvc.as3.multicore.utilities.fabrication.components.AirApplication;

    public class TestAirApplication extends AirApplication {
        public function TestAirApplication()
        {
            super();
        }

        override public function getStartupCommand():Class
        {
            return TestApplicationStartupCommand;
        }
    }
}