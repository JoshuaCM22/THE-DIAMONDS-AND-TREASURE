package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	public class PointBurst extends Sprite // Created by: Joshua C. Magoliman
	{
		// text style
		static const $FONT_FACE:String = "Arial";
		static const $FONT_SIZE:int = 20;
		static const $FONT_BOLD:Boolean = false;
		static const $FONT_COLOR:Number = 0xFFFFFF;
		// animation
		static const $ANIMATE_STEPS:int = 10;
		static const $ANIMATE_STEP_TIME:int = 50;
		static const $START_SCALE:Number = 0;
		static const $END_SCALE:Number = 2.0;
		private var _textField:TextField;
		private var _burstSprite:Sprite;
		private var _parentMovieClip:MovieClip;
		private var _animateTimer:Timer;
		public function PointBurst(mc:MovieClip,pts:Object,x,y:Number):void
		{
			// create text format
			var textFormat:TextFormat = new TextFormat  ;
			textFormat.font = $FONT_FACE;
			textFormat.size = $FONT_SIZE;
			textFormat.bold = $FONT_BOLD;
			textFormat.color = $FONT_COLOR;
			textFormat.align = "center";
			// create text field
			_textField = new TextField  ;
			_textField.embedFonts = true;
			_textField.selectable = false;
			_textField.defaultTextFormat = textFormat;
			_textField.autoSize = TextFieldAutoSize.CENTER;
			_textField.text = String(pts);
			_textField.x =  -  _textField.width / 2;
			_textField.y =  -  _textField.height / 2;
			// create sprite
			_burstSprite = new Sprite  ;
			_burstSprite.x = x;
			_burstSprite.y = y;
			_burstSprite.scaleX = $START_SCALE;
			_burstSprite.scaleY = $START_SCALE;
			_burstSprite.alpha = 0;
			_burstSprite.addChild(_textField);
			_parentMovieClip = mc;
			_parentMovieClip.addChild(_burstSprite);
			// start animation;
			_animateTimer = new Timer($ANIMATE_STEP_TIME,$ANIMATE_STEPS);
			_animateTimer.addEventListener(TimerEvent.TIMER,rescaleBurst);
			_animateTimer.addEventListener(TimerEvent.TIMER_COMPLETE,removeBurst);
			_animateTimer.start();
		}
		// animate;
		public function rescaleBurst(event:TimerEvent):void
		{
			// how far along are we
			var percentDone:Number = event.target.currentCount / $ANIMATE_STEPS;
			// set scale and alpha
			_burstSprite.scaleX = (1.0 - percentDone) * $START_SCALE + percentDone * $END_SCALE;
			_burstSprite.scaleY = (1.0 - percentDone) * $START_SCALE + percentDone * $END_SCALE;
			_burstSprite.alpha = 1.0 - percentDone;
		}
		// all done, remove self
		public function removeBurst(event:TimerEvent):void
		{
			_burstSprite.removeChild(_textField);
			_parentMovieClip.removeChild(_burstSprite);
			_textField = null;
			_burstSprite = null;
			delete this;
		}
	}
}