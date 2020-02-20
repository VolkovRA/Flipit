package mvc.model.data.board;

import haxe.ds.Vector;
import mvc.model.chip.ChipState;
import mvc.model.data.level.LevelData.LevelID;

/**
 * Данные игровой доски.
 * @author VolkovRA
 */
class BoardData 
{
	/**
	 * ID Игровой доски. (Уникальный)
	 * По умолчанию: 0.
	 */
	public var id:BoardID = 0;
	
	/**
	 * ID Игрового уровня, к которому относится данная доска.
	 * По умолчанию: 0. (Нет связи)
	 */
	public var level:LevelID = 0;
	
	/**
	 * Данные игрового поля.
	 * Может быть null.
	 */
	public var data:Vector<Vector<ChipState>> = null;
	
	/**
	 * Создать данные игровой доски.
	 */
	public function new() {
	}
}

/**
 * ID Игровой доски.
 */
typedef BoardID = ID;