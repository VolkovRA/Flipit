package mvc.model.data.board;

import mvc.model.Model;
import mvc.model.data.DataList;
import mvc.model.data.level.LevelData.LevelID;

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
	 * Получить игровую доску по её ID игрового уровня.
	 * Возвращает первую найденную игровую доску для указанного id уровня или null, если такой доски нет.
	 * @param	level ID Уровня.
	 */
	public function getBoardByLevel(level:LevelID):BoardData {
		for (item in this) {
			if (item.level == level)
				return item;
		}
		
		return null;
	}
}