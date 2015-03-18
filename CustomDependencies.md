# Introduction #

Fabrication uses IoC mechanism to manipulate dependencies inside itself ( pureMVC actors management ). From version 0.7.5 there is possibility to use similar mechanism to provide custom dependencies injection.

# Requirements #

Custom dependencies are available since Fabrication 0.7.5

# Usage scenario #

To provide custom dependencies injection you have to use dependencies providers ( [IDependencyProvider](http://code.google.com/p/fabrication/source/browse/framework/trunk/src/org/puremvc/as3/multicore/utilities/fabrication/injection/provider/IDependenciesProvider.as) ) wich should
be added to facade. You can define you own implementation or use framework [DependenciesProvider](http://code.google.com/p/fabrication/source/browse/framework/trunk/src/org/puremvc/as3/multicore/utilities/fabrication/injection/provider/DependenciesProvider.as) class:

**LoginDataProvider.as**
```
<fabrication:DependenciesProvider xmlns:fx="http://ns.adobe.com/mxml/2009"
    xmlns:fabrication="http://puremvc.org/utilities/fabrication/2010">
    <fx:Array id="loginData">
        <fx:Object login="eric" pass="cartman"/>
        <fx:Object login="stan" pass="marsh"/>
    </fx:Array>
</fabrication:DependenciesProvider>
```

**Below approach is deprecated**:
Then, before you can reference loginData array, you have to add provider to facade ( you can do it in command ):
```
override public function execute(notification:INotification):void
{
      super.execute(notification);
      
      // add as class
      addDependenciesProvider( LoginDataProvider );
      
      // add as instance
      addDependenciesProvider( new LoginDataProvider() );      
            
}
```

**Use this one instead:**

In your application ( module ) override dependencyProviders getter:
```

public function get dependencyProviders():Array 
{
       return super.dependencyProviders.concat ( [ LoginDataProvider ] );
}
```

To use dependency element approach similar strategy as in fabrication actors IoC functionality:

**LoginProxy.as**
```
package model {
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;

    public class LoginProxy extends FabricationProxy {

        static public const NAME:String = "LoginProxy";

        [Inject("loginData")]
        public var loginData:Array;

        public function LoginProxy()
        {
            super(NAME);
        }

}
```

# Examples #
  1. DependenciesProvider mechanism example [Demo](http://fabrication.googlecode.com/svn/examples/dependencies_provider/bin/index.html) [Source](http://code.google.com/p/fabrication/source/browse/#svn/examples/dependencies_provider)