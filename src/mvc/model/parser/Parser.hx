package mvc.model.parser;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.parser.json.ParserJSON;

/**
 * Парсер игровых данных.
 * Класс содержит реализацию парсеров для целевого формата данных.
 * @author VolkovRA
 */
class Parser extends AModel 
{
	/**
	 * JSON Парсер.
	 * Не может быть null.
	 */
	public var json(default, null):ParserJSON;
	
	/**
	 * Создать парсер игровых данных.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
		
		json = new ParserJSON(model);
	}
}