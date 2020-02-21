package ui;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * Кнопка.
 * Простая, базовая реализация обычной кнопки.
 * @author VolkovRA
 */
class Button extends Sprite 
{
	/**
	 * Скин.
	 * По умолчанию: null.
	 */
	public var skin(default, set):DisplayObject = null;
	/**
	 * Скин наведения на кнопку.
	 * По умолчанию: null.
	 */
	public var skinHover(default, set):DisplayObject = null;
	/**
	 * Скин нажажатия на кнопку.
	 * По умолчанию: null.
	 */
	public var skinPress(default, set):DisplayObject = null;
	/**
	 * Состояние кнопки.
	 * При изменений состояния диспетчерезируется событие: Event.CHANGE.
	 * По умолчанию: ButtonState.NORMAL;
	 */
	public var state(default, set):ButtonState = ButtonState.NORMAL;
	/**
	 * Контейнер с шкурками.
	 * Содержимое управляется классом Button.
	 * Не может быть null.
	 */
	public var skinWrap(default, null):Sprite;
	
	/**
	 * Создать кнопку.
	 */
	public function new() {
		super();
		
		skinWrap				= new Sprite();
		skinWrap.mouseChildren	= false;
		addChild(skinWrap);
		
		buttonMode				= true;
		
		// События:
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	// ЛИСТЕНЕРЫ
	private function onRemovedFromStage(e:Event):Void {
		state = ButtonState.NORMAL;
	}
	private function onMouseOver(e:MouseEvent):Void {
		state = ButtonState.HOVER;
	}
	private function onMouseOut(e:MouseEvent):Void {
		state = ButtonState.NORMAL;
	}
	private function onMouseDown(e:MouseEvent):Void {
		state = ButtonState.PRESS;
	}
	private function onMouseUp(e:MouseEvent):Void {
		state = ButtonState.HOVER;
	}
	
	// ПРИВАТ
	private function updateState():Void {
		skinWrap.removeChildren();
		
		if (state == ButtonState.NORMAL ) {
			if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
		
		if (state == ButtonState.HOVER) {
			if (skinHover != null)
				skinWrap.addChild(skinHover);
			else if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
		
		if (state == ButtonState.PRESS) {
			if (skinPress != null)
				skinWrap.addChild(skinPress);
			else if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
	}
	
	// СЕТТЕРЫ
	function set_skin(value:DisplayObject):DisplayObject {
		if (skin == value)
			return value;
		
		if (skin != null) {
			if (skin.parent == this)
				removeChild(skin);
			
			skin = null;
		}
		
		if (value != null) {
			skin = value;
		}
		
		updateState();
		
		return value;
	}
	function set_skinHover(value:DisplayObject):DisplayObject {
		if (skinHover == value)
			return value;
		
		if (skinHover != null) {
			if (skinHover.parent == this)
				removeChild(skinHover);
			
			skinHover = null;
		}
		
		if (value != null) {
			skinHover = value;
		}
		
		updateState();
		
		return value;
	}
	function set_skinPress(value:DisplayObject):DisplayObject {
		if (skinPress == value)
			return value;
		
		if (skinPress != null) {
			if (skinPress.parent == this)
				removeChild(skinPress);
			
			skinPress = null;
		}
		
		if (value != null) {
			skinPress = value;
		}
		
		updateState();
		
		return value;
	}
	function set_state(value:ButtonState):ButtonState {
		if (state == value)
			return value;
		
		state = value;
		updateState();
		dispatchEvent(new Event(Event.CHANGE));
		
		return value;
	}
}

/**
 * Состояние кнопки.
 * Описание всех возможных состоянии кнопки.
 * @author VolkovRA
 */
@:enum
abstract ButtonState(String)
{
	/**
	 * Обычное состояние кнопки.
	 */
	var NORMAL = "normal";
	
	/**
	 * Наведение курсора на кнопку.
	 */
	var HOVER = "hover";
	
	/**
	 * Нажатие на кнопку.
	 */
	var PRESS = "press";
}