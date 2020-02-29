package ui;

import mvc.model.chip.ChipState;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import volkovRA.openfl.animation.Animation;

/**
 * Фишка на игровом поле.
 * @author VolkovRA
 */
class ChipButton extends Sprite 
{
	/**
	 * Отступ по ширине. (px)
	 * Копка имеет центр в середине, это свойство указывает, сколько от центра до крайней левой стороны. (Визуально)
	 */
	static public inline var OFFSET_X:Float		= 24;
	/**
	 * Отступ по высоте. (px)
	 * Копка имеет центр в середине, это свойство указывает, сколько от центра до верхней стороны. (Визуально)
	 */
	static public inline var OFFSET_Y:Float		= 24;
	
	/**
	 * Состояние фишки.
	 * По умолчанию: ChipState.BLACK.
	 */
	public var state(default, set):ChipState;
	/**
	 * Индекс кнопки по X.
	 * Используется родителем для удобной адресации.
	 * По умолчанию: 0.
	 */
	public var indexX:Int = 0;
	/**
	 * Индекс кнопки по Y.
	 * Используется родителем для удобной адресации.
	 * По умолчанию: 0.
	 */
	public var indexY:Int = 0;
	
	// Приват
	private var sensor:Sprite;
	private var black:Animation;
	private var white:Animation;
	
	/**
	 * Создать фишку.
	 */
	public function new() {
		super();
		
		// Построение
		// Сенсор:
		sensor				= new Sprite();
		sensor.buttonMode	= true;
		sensor.alpha		= 0;
		sensor.graphics.beginFill(0xff0000);
		sensor.graphics.drawRect(-OFFSET_X, -OFFSET_Y, 49, 49);
		addChild(sensor);
		
		// Черный скин:
		black				= new Animation();
		black.fps			= 29;
		black.x				= -15 - OFFSET_X;
		black.y				= -15 - OFFSET_Y;
		black.mouseChildren	= false;
		black.mouseEnabled	= false;
		black.repeat		= false;
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/2.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/3.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/4.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/5.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/6.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/7.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/8.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/9.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/10.png")));
		black.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/11.png")));
		
		// Белый скин:
		white 				= new Animation();
		white.fps			= 29;
		white.x				= -15 - OFFSET_X;
		white.y				= -15 - OFFSET_Y;
		white.mouseChildren	= false;
		white.mouseEnabled	= false;
		white.repeat		= false;
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/12.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/13.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/14.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/15.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/16.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/17.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/18.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/19.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/20.png")));
		white.addFrame(new Bitmap(Assets.getBitmapData("assets/image/tile/1.png")));
		
		// Состояние:
		state = ChipState.BLACK;
		
		// События:
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	/**
	 * Запустить анимацию переворота в текущее состояние: state.
	 * Запускает покадровую анимацию фишки.
	 */
	public function playAnimationIn():Void {
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		white.currentFrame = 1;
		black.currentFrame = 1;
	}
	
	// ЛИСТЕНЕРЫ
	private function onRemovedFromStage(e:Event):Void {
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		white.currentFrame = white.totalFrames;
		black.currentFrame = black.totalFrames;
	}
	private function onEnterFrame(e:Event):Void {
		if (state == ChipState.BLACK) {
			black.advanceTime(1 / 30);
			
			if (black.currentFrame == black.totalFrames)
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		else {
			white.advanceTime(1 / 30);
			
			if (white.currentFrame == white.totalFrames)
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
	
	// СЕТТЕРЫ
	function set_state(value:ChipState):ChipState {
		if (value == state)
			return value;
		
		state = value;
		
		if (value == ChipState.BLACK) {
			if (white.parent == this)
				removeChild(white);
			
			addChild(black);
			black.currentFrame = black.totalFrames;
		}
		else {
			if (black.parent == this)
				removeChild(black);
			
			addChild(white);
			white.currentFrame = white.totalFrames;
		}
		
		return value;
	}
}