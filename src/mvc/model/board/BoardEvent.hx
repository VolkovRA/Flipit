package mvc.model.board;

import openfl.events.Event;
import openfl.events.EventType;

/**
 * Событие игровой доски.
 * @author VolkovRA
 */
class BoardEvent extends Event 
{
	/**
	 * Сброс игровых фишек.
	 */
	public static inline var RESET:EventType<Event>				= "boardReset";
	
	/**
	 * Установка новых размеров игрового поля.
	 */
	public static inline var SIZE:EventType<Event>				= "boardSize";
	
	/**
	 * Изменение состояния фишки на игровом поле.
	 */
	public static inline var CHIP_STATE:EventType<Event>		= "boardChipState";
	
	/**
	 * Позиция фишки по X.
	 * Значение используется для событий: BoardEvent.CHIP_STATE.
	 */
	public var x:Int;
	
	/**
	 * Позиция фишки по Y.
	 * Значение используется для событий: BoardEvent.CHIP_STATE.
	 */
	public var y:Int
	
	/**
	 * Создать событие игрового поля.
	 * @param	type Тип события.
	 */
	public function new(type:String) {
		super(type);
	}
}