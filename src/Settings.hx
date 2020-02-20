package;

import mvc.model.chip.ChipState;

/**
 * Статический класс констант.
 * @author VolkovRA
 */
class Settings 
{
	/**
	 * Текущая версия игрового приложения.
	 * Не может быть null.
	 */
	static public var VERSION:Version = new Version(0, 1, 0);
	
	/**
	 * Выигрышное состояние игровой фишки.
	 * Используется для определения победы.
	 */
	static public inline var CHIP_STATE_WIN:ChipState = ChipState.WHITE;
}