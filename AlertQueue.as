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