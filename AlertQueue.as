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
    
    import mx.core.IFlexModuleFactory;

    public class AlertQueue
    {
        // The Singleton instance
        
        private static var _instance:AlertQueue = new AlertQueue();
        
        // vars
        
        private var _queuedAlerts:Array;
        private var _alerting:Boolean;
        
        // constructor
        
        public function AlertQueue()
        {
            if(_instance) {
                throw new Error("Cannot create a new AlertQueue, instead call AlertQueue.push");
            }
            _queuedAlerts = new Array();
        }
        
        // static methods
        
        public static function push(text:String="", 
                                    title:String="", 
                                    flags:uint=4, 
                                    parent:Sprite=null, 
                                    closeHandler:Function=null, 
                                    iconClass:Class=null, 
                                    defaultButtonFlag:uint=4, 
                                    moduleFactory:IFlexModuleFactory=null):void
        {
            // pass all these parameters to the new QueuedAlert instance
            var qa:QueuedAlert = new QueuedAlert(text,
                                                 title,
                                                 flags,
                                                 parent,
                                                 closeHandler,
                                                 iconClass,
                                                 defaultButtonFlag,
                                                 moduleFactory);
            
            // push the newly QueuedAlert onto the stack 
            _instance.push(qa);
        }
        
        //-------
        
        internal static function afterAlert():void
        {
            _instance.afterAlert();
        }
        
        // instance methods
        
        private function push(qa:QueuedAlert):void
        {
            _queuedAlerts.push(qa);
            render();
        }
        
        //-------
        
        private function render():void
        {
            if(_alerting || !_queuedAlerts.length) return;
            _alerting = true;
            var qa:QueuedAlert = _queuedAlerts.shift();
            qa.alert();
        }
        
        //-------
        
        private function afterAlert():void
        {
            _alerting = false;
            render();
        }
    }
}