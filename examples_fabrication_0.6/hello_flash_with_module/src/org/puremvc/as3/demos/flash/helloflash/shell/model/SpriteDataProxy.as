/*
 PureMVC AS3 / Flash Demo - HelloFlash
 By Cliff Hall <clifford.hall@puremvc.org>
 Copyright(c) 2007-08, Some rights reserved.
 */
package org.puremvc.as3.demos.flash.helloflash.shell.model {
	import org.puremvc.as3.demos.flash.helloflash.common.CommonConstants;	
	import org.puremvc.as3.multicore.utilities.fabrication.patterns.proxy.FabricationProxy;	
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;    

	public class SpriteDataProxy extends FabricationProxy
    {
        public static const NAME:String = 'SpriteDataProxy';

        public function SpriteDataProxy( )
        {
            super( NAME, Number(0) );
			palette = [ blue, red, yellow, green, cyan ];
        }

		private var palette:Array;
		private var red:uint 	= 0xFF0000;
		private var green:uint  = 0x00FF00;
		private var blue:uint   = 0x0000FF;
		private var yellow:uint = 0xFFFF00;
		private var cyan:uint	= 0x00FFFF;

		// 
		public function nextSpriteColor( startColor:uint ):uint
		{
			// identify color index
			var index:int;
			var found:Boolean = false;
			for ( var j:int=0; j<palette.length; j++)
			{
				index = j;
				if (startColor == palette[index]) break;
			}
			
			// select the next color in the palette
			index = (index == palette.length-1)?0:index+1;
			//return startColor;
			return palette[index];
			
		}
		
	    /**
		 * Get the next Sprite ID
		 */
		public function get nextSpriteID():String{
			spriteCount++;
			
			routeNotification(CommonConstants.SPRITE_COUNT_CHANGED, spriteCount);
			return "sprite"+spriteCount;
		}
		
		/**
		 * Get the next Sprite ID
		 */
		public function get spriteCount():Number{
			return data as Number;
		}
		
		public function set spriteCount(count:Number):void
		{
			data = count;
		}
		
     }
}