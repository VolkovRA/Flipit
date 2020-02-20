package mvc.model;

import mvc.model.game.Game;
import mvc.model.parser.Parser;

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
	public var parser(default, null):Parser = null;
	
	/**
	 * Экземпляр запущенной игры.
	 * По умолчанию: null.
	 */
	public var game(default, null):Game = null;
	
	/**
	 * Создать главную, игровую модель.
	 */
	public function new() {
		super(this);
		
		parser	= new Parser(this);
		game	= new Game(this);
	}
}