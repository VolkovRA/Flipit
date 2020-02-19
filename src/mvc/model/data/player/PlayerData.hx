package mvc.model.data.player;

/**
 * Данные игрока.
 * @author VolkovRA
 */
class PlayerData 
{
	/**
	 * ID Игрока. (Уникальный)
	 * По умолчанию: 0.
	 */
	public var id:PlayerID = 0;
	
	/**
	 * Имя игрока.
	 * Не может быть null.
	 * По умолчанию: "Player".
	 */
	public var name(default, set):String = "Player";
	
	/**
	 * Количество набранных игроком очков.
	 * По умолчанию: 0.
	 */
	public var score:Float = 0;
	
	/**
	 * Создать данные игрока.
	 */
	public function new() {
	}
	
	// СЕТТЕРЫ
	function set_name(value:String):String {
		return name = (value == null ? "" : value);
	}
}

/**
 * ID Игрока.
 */
typedef PlayerID = ID;