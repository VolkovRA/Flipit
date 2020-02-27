package mvc.model.data.level;

import mvc.model.Model;
import mvc.model.data.DataList;

/**
 * Список данных игровых уровней.
 * @author VolkovRA
 */
class LevelDataList extends DataList<LevelData> 
{
	/**
	 * @inheritDoc
	 */
	public function new(model:Model) {
		super(model);
	}
	
	/**
	 * Получить данные следующего уровня.
	 * Возвращает null, если данные следующиего уровня отсутствуют.
	 * @param	num Номер текущего уровня.
	 */
	public function getNextLevel(num:Int):LevelData {
		var min:Int			= 2147483647;
		var item:LevelData	= null;
		for (level in this) {
			if (level.num > num && level.num < min) {
				min			= level.num;
				item		= level;
			}
		}
		
		return item;
	}
}