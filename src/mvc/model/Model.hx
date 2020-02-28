package mvc.model;

import mvc.model.game.Game;
import mvc.model.parser.ParserManager;
import mvc.model.storage.StorageManager;

/**
 * Главная, игровая модель.
 * @author VolkovRA
 */
class Model extends AModel 
{
	/**
	 * Парсеры игровых данных.
	 * Не может быть null.
	 */
	public var parser(default, null):ParserManager;
	/**
	 * Хранилища игровых данных.
	 * Не может быть null.
	 */
	public var storage(default, null):StorageManager;
	/**
	 * Экземпляр запущенной игры.
	 * Не может быть null.
	 */
	public var game(default, null):Game;
	
	/**
	 * Создать главную, игровую модель.
	 */
	public function new() {
		super(this);
		
		parser	= new ParserManager(this);
		game	= new Game(this);
		storage	= new StorageManager(this);
	}
}