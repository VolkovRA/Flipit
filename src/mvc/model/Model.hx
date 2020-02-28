package mvc.model;

import mvc.model.game.Game;
import mvc.model.parser.Parser;
import mvc.model.storage.StorageManager;

/**
 * Главная, игровая модель.
 * @author VolkovRA
 */
class Model extends AModel 
{
	/**
	 * Парсер игровых данных.
	 * Не может быть null.
	 */
	public var parser(default, null):Parser;
	/**
	 * Хранилища игровых данных.
	 * Не может быть null.
	 */
	public var storage(default, null):StorageManager;
	/**
	 * Экземпляр запущенной игры.
	 * Не может быть null.
	 */
	public var game(default, null):Game = null;
	
	/**
	 * Создать главную, игровую модель.
	 */
	public function new() {
		super(this);
		
		parser	= new Parser(this);
		game	= new Game(this);
		storage	= new StorageManager(this);
	}
}