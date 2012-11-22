// FlexAlertQueue by John Isaacks (jisaacks.com)
// 
// Copyright (c) 2012 John Isaacks
// 
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package FlexAlertQueue
{
    import flash.display.Sprite;
    import flash.events.Event;
    
    import mx.controls.Alert;
    import mx.core.IFlexModuleFactory;
    
    public class QueuedAlert
    {
        // properties for the Alert
        
        private var _text:String;
        private var _title:String;
        private var _flags:uint;
        private var _container:Sprite;
        private var _closeHandler:Function;
        private var _iconClass:Class;
        private var _defaultButtonFlag:uint;
        private var _moduleFactory:IFlexModuleFactory;
        
        // constructor
        
        public function QueuedAlert(text:String="", 
                                    title:String="", 
                                    flags:uint=4, 
                                    parent:Sprite=null, 
                                    closeHandler:Function=null, 
                                    iconClass:Class=null, 
                                    defaultButtonFlag:uint=4, 
                                    moduleFactory:IFlexModuleFactory=null)
        {
            // store all these params to later be passed to Alert.show
            this._text = text;
            this._title = title;
            this._flags = flags;
            this._container = parent;
            this._closeHandler = closeHandler;
            this._iconClass = iconClass;
            this._defaultButtonFlag = defaultButtonFlag;
            this._moduleFactory = moduleFactory;
        }
        
        // methods
        
        internal function alert():void
        {
            Alert.show(this._text,
                       this._title,
                       this._flags,
                       this._container,
                       this.closeHandler,
                       this._iconClass,
                       this._defaultButtonFlag,
                       this._moduleFactory);
        }
        
        //-------
        
        public function closeHandler(e:Event):void
        {
            AlertQueue.afterAlert();
            if(this._closeHandler != null) {
                this._closeHandler(e);  
            }
        }
    }
}