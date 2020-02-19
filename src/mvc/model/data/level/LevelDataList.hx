package mvc.model.data.level;

import mvc.model.Model;
import mvc.model.data.list.DataList;

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
}