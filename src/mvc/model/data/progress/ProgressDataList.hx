package mvc.model.data.progress;

import mvc.model.Model;
import mvc.model.data.DataList;
import mvc.model.data.level.LevelData.LevelID;

/**
 * Список данных игрового прогресса.
 * @author VolkovRA
 */
class ProgressDataList extends DataList<ProgressData> 
{
	/**
	 * @inheritDoc
	 */
	public function new(model:Model) {
		super(model);
	}
	
	/**
	 * Проверить, пройден ли указанный уровень.
	 * Возвращает true, если указанный уровень был успешно пройден, иначе false,
	 * @param	level ID Уровня.
	 */
	public function isLevelCompleted(level:LevelID):Bool {
		for (item in this) {
			if (item.level == level) {
				if (item.completed)
					return true;
				else
					return false;
			}
			else
				continue;
		}
		
		return false;
	}
}