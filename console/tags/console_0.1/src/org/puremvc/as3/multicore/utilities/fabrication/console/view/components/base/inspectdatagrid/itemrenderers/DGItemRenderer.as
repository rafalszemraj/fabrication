/*
 * Copyright (C) 2009 Rafał Szemraj, ( http://szemraj.eu )
 *
 * Tequila, The Ministry Of Ideas Co. Ltd.
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
package org.puremvc.as3.multicore.utilities.fabrication.console.view.components.base.inspectdatagrid.itemrenderers {


    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridItemRenderer;

    public class DGItemRenderer extends DataGridItemRenderer {


        public function DGItemRenderer()
        {
            selectable = true;
        }

        override public function validateNow():void {
	        
	        super.validateNow();
	        if( listData ) y = listData.rowIndex * ( listData.owner as DataGrid ).rowHeight - 2;
	        
	    }

        

    }
}