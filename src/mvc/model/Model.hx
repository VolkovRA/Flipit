package mvc.model;

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
	public var parser(default, null):Parser;
	
	/**
	 * Создать главную, игровую модель.
	 */
	public function new() {
		super(this);
		
		parser = new Parser(this);
		
		//trace(parser.json.read(openfl.Assets.getText("assets/config/levels.json")));
	}
}