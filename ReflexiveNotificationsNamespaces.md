# Introduction #
Reflexive notifications via namespaces is new idea of mediator interests registration. Instead using **reactTo`<`NoteName`>`** syntax we can declare **processNotification** method in namespace related to our notification.
In other words - given notification is processed by mediators by the same method used in related namespace.

# Requirements #
This feature requires Fabrication version 0.7.2 or above.

# Usage scenarios #
Instead of define notifications as constants in classes, we use namespace as an notification name declaration:

**notification.as**
```
package notifications {

    public namespace notification = "notification";

}
```
Then, in our mediator we can do the following:

**Mediator.as**
```
package view {
    import notifications.notification;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    import spark.components.TextArea;

    public class TextAreaMediatorWithNamespaceNotificationRespond extends FlexMediator {

        static public const NAME:String = "TextAreaMediatorWithNamespaceNotificationRespond";

        public function TextAreaMediatorWithNamespaceNotificationRespond(viewComponent:TextArea)
        {
            super(NAME, viewComponent);
        }

       // here we are processing notification
        notification function processNotification(notification:INotification):void
        {
            component.appendText( "respond to namespace note.\n" );
        }

        // here we are processing another notification
        other_notification_as_namespace function processNotification(notification:INotification):void
        {
            component.appendText( "respond to other_notification_as_namespace note.\n" );
        }

        // here we are sending notification
        public function sendNote():void
       {                     
          sendNotification( notification, getMediatorName() );
       }

        public function get component():TextArea
        {
            return viewComponent as TextArea;
        }

    }
}
```

# Additional info #
  1. Pros:
    * we have typed notification ( as namespaces ) not as strings, so we're doing less errors
    * using good code editor we can change notification name and all needed references ( wich is hard with respondTo )
  1. Cons:
    * each notification name must be declared as namespace ( one file per notification )

# Examples #
  1. Namespace notifications example [Demo](http://fabrication.googlecode.com/svn/examples/namespace_notifications_example/bin/index.html) [Source](http://code.google.com/p/fabrication/source/browse/#svn/examples/namespace_notifications_example)