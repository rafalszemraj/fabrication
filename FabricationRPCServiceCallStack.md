# Introduction #

Service call stack is little utility that allows you to create multiple calls to server.

# Details #

In ServiceCallStack You can define how much calls should be executed at one time, so you can have them one after another, or all at the same time, if you want to. Here is example how to use it:

Let's have simple FabricationRemoteProxy instance. Then, we create getter which returns one call stack with two calls inside.
```
package model {

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationRemoteProxy;
    import org.puremvc.as3.multicore.utilities.fabrication.utils.ServiceCall;
    import org.puremvc.as3.multicore.utilities.fabrication.utils.ServiceCallStack;

    import services.SomeService;
    import model.vo.User;

    public class SomeProxy extends FabricationRemoteProxy {

        static public const NAME:String = "SomeProxy";

        [Inject("someService")]
        public var someService:SomeService;

        public function UserProxy()
        {
            super(NAME);
            expansion = false;
            user = new User( "name" );
        }

        public function makeCall():void {

             executeServiceCallStack( callStack );

        }

        private function get callStack():ServiceCallStack {
 
            var cStack:ServiceCallStack = new ServiceCallStack( callStackComplete, 1 );
            var callOne:ServiceCall = new ServiceCall( someService.saveUser, [user], onSaveUserComplete );
            var callTwo:ServiceCall = new ServiceCall( someService.getUsers, null, onGetUsersComplete );
            cStack.addServiceCall( callOne );
            cStack.addServiceCall( callTwo );
            return cStack;
                
        }

        private function callStackComplete():void {

             trace( "callStack completed");

        }

        private function onSaveUserComplete( event:ResultEvent ):void {

             trace( "callStack completed");

        }

        private function onGetUsersComplete( event:ResultEvent ):void {

             trace( "callStack completed");

        }



    }
}
```

In this example we're creating service call stack passing in constructor function wich will be called when are stack calls are completed. Second param tells how many calls we want to be executed at the time. When you create service call you have to pass method as a first argument ( **Remember that this method should return AsyncToken object** ), next params ( callFunction  arguments array, result and fault handlers ) are optional. You can treat call stack as a single call and add it to another stack!.