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