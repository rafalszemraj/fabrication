

# Introduction #
Flex components have the ability to delay instantiation to improve performance. This behaviour differs in various components and depends on the `creationPolicy` used. A PureMVC Mediator typically expects that the viewComponent associated with it has already been initialized prior to registration. But components with deferred instantiation are not available at the time of the mediator's registration. Hence, A workaround is needed to listen for creationComplete from such components and then register the mediator associated with it.

[This approach](http://puremvc.org/content/view/92/1/) generally consists of the following steps.

  1. Add a creationComplete event on the component in question.
  1. Bubble a custom event from this creationComplete.
  1. In the base Mediator listen for this event.
  1. Create switch case to handle these events.
  1. In the switch case create the mediator if it has not been created.

This becomes very cumbersome when you have a lot of components that use deferred instantiation and can quickly become unmanageable.

Reflexive mediator registration takes away the pain of working with deferred instantiation. Fabrication has a built-in component resolver that can sense when a mediator's viewComponent is created. Once the mediator component has been created successfully, it registers the mediator with the application facade.

# Requirements #
As of Fabrication 0.5.x this feature is only available with Flex and when extending the FlexMediator class. Deferred component instantiation is currently not available in Flash CS3 components. Please contact me if you have suggestions on how to implement this feature within Flash/Pure AS3 projects.

# Basic Syntax(child components) #
To use reflexive mediator registration you need to make a small alteration to the way you register mediators in PureMVC.

Instead of using,
```
registerMediator(new MyMediator(viewComponent.childComponent))
```

You wrap the viewComponent in the resolve method and lookup the childComponent on the return value of resolve.
```
registerMediator(new MyMediator(resolve(viewComponent).childComponent))
```

For the mxml,
```
<mx:Application ...>
	<mx:Button id="myButton" label="myButton" />
</mx:Application>
```

The corresponding mediator registration code is,
```
registerMediator(new MyMediator(resolve(application).myButton));
```

# For descendant child components #
Sometimes the viewComponent is deep in a mxml layout hierarchy. In this case you use the **`..`** descendant operator. The descendant operator implies that you want resolve a component that is N level deep within other components.

For the mxml,
```
<mx:ViewStack creationPolicy="queued">
   <mx:ViewStack creationPolicy="queued">
      <mx:ViewStack creationPolicy="queued">
         <mx:Canvas creationPolicy="queued">
            <mx:Button id="myButton" label="Nested Button" />
         </mx:Canvas>
      </mx:ViewStack>
   </mx:ViewStack>
</mx:ViewStack>
```

The corresponding mediator registration code is,
```
registerMediator(new MyMediator(resolve(application)..myButton));
```

# Chaining expressions #
The component resolver supports chaining of multiple expressions together to map to an n-level display hierarchy. This is useful if you wish to explicitly qualify the path to the component.

For the mxml,
```
<mx:VBox id="myVBox">
	<mx:HBox id="myHBox">
		<mx:Button id="myButton" />
	</mx:HBox>
</mx:VBox>
```

The corresponding mediator registration is,
```
registerMediator(new MyMediator(resolve(application).myVBox.myHBox.myButton));
```

# Matching multiple components with the same Mediator #
You can also register the same mediator with multiple components. Fabrication creates a clone of the original mediator in order to do such registration. To indicate that you wish to match multiple components with a mediator you use regular expressions. The mediator name of the clone mediator is suffixed with the id of the resolved component to avoid duplicate mediators.

## Matching child components with Regular Expressions ##
To match child components of the viewComponent with a specific pattern use, the **`.re`** method. This method takes the pattern string to use to match against the component id.

For the mxml,
```
<mx:Application ...>
  <mx:Button id="button1" label="button1" />
  <mx:Button id="button2" label="button2" />
  <mx:Button id="button3" label="button3" />
  <mx:Button id="button4" label="button4" />
</mx:Application>
```

The mediator registration code to associate the ButtonStyleMediator with all buttons is,
```
registerMediator(new ButtonStyleMediator(
   resolve(application).re("button[0-9]+")
));
```

## Matching descendant components with Regular Expressions ##
To match descendant child components of the viewComponent with specific pattern use, the **`..rex`** method. This method also takes the pattern string to use to match against the component id.

For the mxml,
```
<mx:ViewStack creationPolicy="queued">
   <mx:ViewStack creationPolicy="queued">
      <mx:ViewStack creationPolicy="queued">
         <mx:Canvas creationPolicy="queued">
           <mx:Button id="button1" label="button1" />
           <mx:Button id="button2" label="button2" />
           <mx:Button id="button3" label="button3" />
           <mx:Button id="button4" label="button4" />
         </mx:Canvas>
      </mx:ViewStack>
   </mx:ViewStack>
</mx:ViewStack>
```

The corresponding mediator registration code is,
```
registerMediator(new ButtonStyleMediator(
   resolve(application)..rex("button[0-9]+")
));
```

# Automatic Mediator disposal #
Fabrication does automatic removal of mediators after the viewComponent is removed. After removal, If the component is recreated again the mediator will also be recreated for it. The association of a viewComponent to a mediator is retained during the lifecycle of an application. This feature is most useful when used with application states.

# Examples #
  1. Using Reflexive mediators with Application states [[Browse](http://code.google.com/p/fabrication/source/browse/#svn/examples/resolver_add_child/src/main/flex)] [[SVN](http://fabrication.googlecode.com/svn/examples/resolver_add_child)]
  1. Using Reflexive mediators with on demand instatiation [[Browse](http://code.google.com/p/fabrication/source/browse/#svn/examples/resolver_tab_navigator/src/main/flex)] [[SVN](http://fabrication.googlecode.com/svn/examples/resolver_tab_navigator)]