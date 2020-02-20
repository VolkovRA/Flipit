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
	 * Изменение всей доски.
	 * Это событие диспетчерезируется при изменений размеров самой доски или при массовом изменении состояния сразу нескольких фишек.
	 */
	public static inline var CHANGE:EventType<Event>			= "boardChange";
	
	/**
	 * Изменение состояния игровой фишки.
	 * Это событие используется при единичном изменении состояния у одной фишки.
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
	public var y:Int;
	
	/**
	 * Создать событие игрового поля.
	 * @param	type Тип события.
	 */
	public function new(type:String) {
		super(type);
	}
}