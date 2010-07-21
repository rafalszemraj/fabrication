/**
 * Copyright (C) 2010 Rafał Szemraj.
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
package org.puremvc.as3.multicore.utilities.fabrication.console.utils {
    import flash.utils.getQualifiedClassName;

    import mx.collections.ArrayCollection;
    import mx.utils.ObjectUtil;

    public class ObjectParser {
        public function ObjectParser()
        {

        }

        public function isPrimitive(object:*):Boolean
        {

            return ObjectUtil.isSimple(object) && !(object is Array) || object == null;


        }

        public function convertObject(data:*, deepLevel:Number = 0):ArrayCollection
        {

            var recurentArrayCollection:ArrayCollection = new ArrayCollection();
            var innerValue:Object;
            for (var innerData:* in data) {

                innerValue = data[ innerData ];
                var name:String = innerData;
                if (isPrimitive(innerValue) || ( deepLevel > 4 )) {
                    
                    var value:String = "" + innerValue;
                    recurentArrayCollection.addItem({ name:name , value:value, type:getQualifiedClassName(innerValue) });

                }
                else recurentArrayCollection.addItem({ name:name, value:"", type:getQualifiedClassName(innerValue), children:convertObject(innerValue,  deepLevel + 1)});


            }
            return recurentArrayCollection.length ? recurentArrayCollection : null;


        }

        public function buildDataObject( object:*, name:String = "object" ):Object {

        	 if( isPrimitive( object ) ) {

        		  return { name:name, value:"" + object, type:getQualifiedClassName( object ) };

        	 }
       		 else {

            	var dataCollection:ArrayCollection = new ArrayCollection();
            	for( var innerData:* in object ) {

                	dataCollection.addItem( buildDataObject( object[ innerData ], innerData ) );

	            }
	            if( dataCollection.length ) {

         	    	return { name:name, value:"", children:dataCollection, type:getQualifiedClassName( object ) };

         	    }
         	    else return { name:name, value:"" + object, type:getQualifiedClassName( object ) };
         	}


        }
    }
}