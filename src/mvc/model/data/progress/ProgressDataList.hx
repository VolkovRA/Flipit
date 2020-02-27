package mvc.model.data.progress;

import mvc.model.Model;
import mvc.model.data.DataList;
import mvc.model.data.level.LevelData.LevelID;
import mvc.model.data.player.PlayerData.PlayerID;

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
	/**
	 * Получить прогресс игрока на указанный уровень.
	 * Возвращает первую найденную запись о прогрессе игрока на указанный уровень или null, если такой записи нет.
	 * @param	player ID Игрока.
	 * @param	level ID Уровня.
	 */
	public function getPlayerOfLevel(player:PlayerID, level:LevelID):ProgressData {
		for (item in this) {
			if (item.level == level && item.player == player)
				return item;
		}
		
		return null;
	}
}