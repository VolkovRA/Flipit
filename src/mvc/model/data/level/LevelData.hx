package mvc.model.data.level;

/**
 * Данные игрового уровня.
 * @author VolkovRA
 */
class LevelData 
{
	/**
	 * ID Игрового уровня. (Уникальный)
	 * По умолчанию: 0.
	 */
	public var id:LevelID = 0;
	
	/**
	 * Порядковый номер игрового уровня.
	 * По умолчанию: 0.
	 */
	public var num:Int = 0;
	
	/**
	 * Бонус очков на этом уровне.
	 * По умолчанию: 0.
	 */
	public var bonus:Float = 0;
	
	/**
	 * Создать данные игрового уровня.
	 */
	public function new() {
	}
}

/**
 * ID Уровня.
 */
typedef LevelID = ID;