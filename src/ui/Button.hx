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
	 * Если не указан, используется: skin.
	 * По умолчанию: null.
	 */
	public var skinHover(default, set):DisplayObject = null;
	/**
	 * Скин нажажатия на кнопку.
	 * Если не указан, используется: skin.
	 * По умолчанию: null.
	 */
	public var skinPress(default, set):DisplayObject = null;
	/**
	 * Скин выключенного состояния.
	 * Если не указан, используется: skin.
	 * По умолчанию: null.
	 */
	public var skinDisabled(default, set):DisplayObject = null;
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
	 * Кнопка включена.
	 * Это свойство влияет только на отображение шкурки: skinDisabled.
	 * По умолчанию: true.
	 */
	public var enabled(default, set):Bool = true;
	
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
		addEventListener(Event.REMOVED_FROM_STAGE, onButtonRemovedFromStage);
		addEventListener(MouseEvent.MOUSE_OVER, onButtonMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onButtonMouseOut);
		addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onButtonMouseUp);
	}
	
	// ЛИСТЕНЕРЫ
	private function onButtonRemovedFromStage(e:Event):Void {
		state = ButtonState.NORMAL;
	}
	private function onButtonMouseOver(e:MouseEvent):Void {
		state = ButtonState.HOVER;
	}
	private function onButtonMouseOut(e:MouseEvent):Void {
		state = ButtonState.NORMAL;
	}
	private function onButtonMouseDown(e:MouseEvent):Void {
		state = ButtonState.PRESS;
	}
	private function onButtonMouseUp(e:MouseEvent):Void {
		state = ButtonState.HOVER;
	}
	
	// ПРИВАТ
	private function updateState():Void {
		skinWrap.removeChildren();
		
		if (enabled == false) {
			useHandCursor = false;
			
			if (skinDisabled != null)
				skinWrap.addChild(skinDisabled);
			else if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
		
		if (state == ButtonState.NORMAL ) {
			useHandCursor = true;
			
			if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
		
		if (state == ButtonState.HOVER) {
			useHandCursor = true;
			
			if (skinHover != null)
				skinWrap.addChild(skinHover);
			else if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
		
		if (state == ButtonState.PRESS) {
			useHandCursor = true;
			
			if (skinPress != null)
				skinWrap.addChild(skinPress);
			else if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
		
		if (state == ButtonState.DISABLED) {
			useHandCursor = false;
			
			if (skinDisabled != null)
				skinWrap.addChild(skinDisabled);
			else if (skin != null)
				skinWrap.addChild(skin);
			
			return;
		}
	}
	
	// СЕТТЕРЫ
	function set_skin(value:DisplayObject):DisplayObject {
		if (skin == value)
			return value;
		
		skin = value;
		updateState();
		
		return value;
	}
	function set_skinHover(value:DisplayObject):DisplayObject {
		if (skinHover == value)
			return value;
		
		skinHover = value;
		updateState();
		
		return value;
	}
	function set_skinPress(value:DisplayObject):DisplayObject {
		if (skinPress == value)
			return value;
		
		skinPress = value;
		updateState();
		
		return value;
	}
	function set_skinDisabled(value:DisplayObject):DisplayObject {
		if (skinDisabled == value)
			return value;
		
		skinDisabled = value;
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
	function set_enabled(value:Bool):Bool {
		if (value == enabled)
			return value;
		
		enabled = value;
		updateState();
		
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
	
	/**
	 * Выключена.
	 */
	var DISABLED = "disabled";
}