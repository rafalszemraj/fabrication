/**
 * Copyright (C) 2010 Piotr Zarzycki.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package main.view.mediators
{
    import flash.events.Event;

    import main.helpers.PersonVo;
    import main.helpers.SelectedPersonEvent;
    import main.view.components.PersonsList;

    import mx.collections.ArrayCollection;

    import mx.controls.Alert;

    import org.puremvc.as3.multicore.utilities.fabrication.patterns.mediator.FlexMediator;

    public class PersonsListMediator extends FlexMediator
    {
        //---------------------------------------------------------------
		// <------ PUBLIC & PRIVATE CONSTS ------>
		//---------------------------------------------------------------
		//{
        /**
         * Mediator name
         */
        public static const NAME:String = "PersonsListMediator";
        //}
        //---------------------------------------------------------------
		// <------ CTOR ------>
		//{
        public function PersonsListMediator(viewComponent:PersonsList)
        {
            super(NAME, viewComponent);
        }
        //}
        //---------------------------------------------------------------
        // <------ PUBLIC & PRIVATE PROPERTIES ------>

        public function get personsList():PersonsList
        {
            return viewComponent as PersonsList;
        }
        //}
        //---------------------------------------------------------------
        // <------ PUBLIC METHODS/OVERRIDE ------>
        //{

        public override function onRegister():void
        {
            super.onRegister();

            //Example data
            var arr:ArrayCollection = new ArrayCollection([
                 new PersonVo("Piter", "Zarzycki", 25, "Poland"),
                 new PersonVo("Eric", "Kowalski", 35, "Poland"),
                 new PersonVo("John", "Rambo", 30, "USA")
            ]);

            personsList.dg.dataProvider = arr;
        }

        //}
        //---------------------------------------------------------------
        // <------ PRIVATE & PROTECTED METHODS/OVERRIDE ------>
        //{

        //}
        //---------------------------------------------------------------
        // <------ NOTIFICATIONS  ------>
        //{

        //}
        //---------------------------------------------------------------
        // <------ REACTIONS ------>
        //{
        /***
         * Reaction for selectedChanged event in itemrenderer
         *
         * @param Event event
         */
        public function reactToPersonsList$SelectedChanged(event:Event):void
        {
            Alert.show("selectedChange event");
        }

        /**
         * Reaction for selectedPerson event in itemrenderer
         *
         * @param SelectedPersonEvent event
         */
        public function reactToPersonsList$SelectedPerson(event:SelectedPersonEvent):void
        {
            var personVo:PersonVo = event.person;

            personsList.personName.text = personVo.name;
            personsList.surname.text = personVo.surname;
            personsList.age.text = String(personVo.age);
            personsList.country.text = personVo.country;
        }
        //}
        //---------------------------------------------------------------
        // <------ HELPERS METHODS ------>
        //{

        //}
    }
}