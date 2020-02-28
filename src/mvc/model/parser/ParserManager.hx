package mvc.model.parser;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.parser.json.ParserJSON;

/**
 * Менеджер парсеров.
 * Содержит все доступные парсеры.
 * @author VolkovRA
 */
class ParserManager extends AModel 
{
	/**
	 * JSON Парсер.
	 * Не может быть null.
	 */
	public var json(default, null):IParser;
	
	/**
	 * Создать менеджер парсеров.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
		
		json = new ParserJSON(model);
	}
}