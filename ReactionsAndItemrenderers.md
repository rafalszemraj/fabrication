# Introduction #
Below is presented how to use mechanism of reactions conjuction with itemrenderers.
# Requirements #
Mechanism of reactions needs Fabrication version 0.7.1 or above.
# Usage Scenerio #
Consider creation of DataGrid control and itemrenderer for one of the column in this DataGrid.

**DataGrid**

```
<s:DataGrid id="dg"
            width="400"
            height="250">
        <s:columns>
            <s:ArrayList>
               <s:GridColumn headerText="Name"
                             dataField="name"/>
                <s:GridColumn headerText="Surname"
                              dataField="surname"/>
                <s:GridColumn headerText="Details"
                              width="100"  itemRenderer="main.view.components.DgItemRenderer"/>
            </s:ArrayList>
        </s:columns>
</s:DataGrid>
```
Created itemrenderer contains CheckBox control.

**DgItemRenderer.mxml**

```
<s:GridItemRenderer xmlns:fx="http://ns.adobe.com/mxml/2009"
                    xmlns:s="library://ns.adobe.com/flex/spark">

    <s:CheckBox height="25"
                horizontalCenter="0"/>
</s:GridItemRenderer>
```
DataGrid control is created in Group container and registered mediator for this container.
If you whant using reaction for subscribing "Change" event Checkbox control in itemrenderer you must consider following steps:

  1. Inside Group container with created above DataGrid you must creat event of your choosing name:

```
<fx:Metadata>

        /**
         *  Declare item renderer events
         */
        
        [Event(name="selectedPerson", type="main.helpers.SelectedPersonEvent")]
        [Event(name="selectedChanged", type="flash.events.Event")]
</fx:Metadata>
```

> 2. Create method handler for "Change" event CheckBox and dispatch "selectedChanged" event with bubbles mode.

```
<s:GridItemRenderer xmlns:fx="http://ns.adobe.com/mxml/2009"
                    xmlns:s="library://ns.adobe.com/flex/spark">

    <s:CheckBox height="25"
                horizontalCenter="0"
                change="onChangeCheckBox(event)"/>
    <fx:Script>
        <![CDATA[

        /***
         * Create event with bubbles and dispatch it
         * 
         * @param Event event
         */
        private function onChangeCheckBox(event:Event):void
        {
            dispatchEvent(new Event("selectedChanged", true));
        } 
       ]]>
    </fx:Script>
</s:GridItemRenderer>
```

> 3. Use reaction in registered Mediator for "selectedChanged" event.

**Property for viewComponent in mediator**

```
public function get personsList():PersonsList
{
     return viewComponent as PersonsList;
}
```

**Reaction for selectedChanged**

```
public function reactToPersonsList$SelectedChanged(event:Event):void
{
     Alert.show("selectedChange event");
}
```

# Examples #
  1. Reactions in itemrenderers: [Demo](http://fabrication.googlecode.com/svn/examples/reactions_itemrenderer_example/bin/index.html) [Source](http://code.google.com/p/fabrication/source/browse/#svn/examples/reactions_itemrenderer_example/)