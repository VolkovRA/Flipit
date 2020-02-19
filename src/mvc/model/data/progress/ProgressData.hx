package mvc.model.data.progress;

import mvc.model.data.player.PlayerData;
import mvc.model.data.level.LevelData;

/**
 * Данные прогресса в игре.
 * @author VolkovRA
 */
class ProgressData 
{
	/**
	 * ID Прогресса. (Уникальный)
	 * По умолчанию: 0.
	 */
	public var id:ProgressID = 0;
	
	/**
	 * ID Игрового уровня.
	 * По умолчанию: 0.
	 */
	public var level:LevelID = 0;
	
	/**
	 * ID Игрока, к которому относится данный прогресс.
	 * По умолчанию: 0.
	 */
	public var player:PlayerID = 0;
	
	/**
	 * Уровень пройден.
	 * По умолчанию: false.
	 */
	public var completed:Bool = false;
	
	/**
	 * Создать прогресс.
	 */
	public function new() {
	}
}

/**
 * ID Прогресса.
 */
typedef ProgressID = ID;