package mvc.model.data.board;

import mvc.model.Model;
import mvc.model.data.list.DataList;

/**
 * Список данных игровых досок.
 * @author VolkovRA
 */
class BoardDataList extends DataList<BoardData> 
{
	/**
	 * @inheritDoc
	 */
	public function new(model:Model) {
		super(model);
	}
	
	/**
	 * Получить доску игрового уровня.
	 * Возвращает первую найденную игровую доску для указанного номера уровня или null, если для запрошенного уровня доски нет.
	 * @param	level Номер игрового уровня.
	 */
	public function getBoardByLevel(level:Int):BoardData {
		for (item in this) {
			if (item.level == level)
				return item;
		}
		
		return null;
	}
}