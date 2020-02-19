package mvc.model.data.level;

import mvc.model.data.list.DataList;
import mvc.model.Model;

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