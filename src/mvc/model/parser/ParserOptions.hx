package mvc.model.parser;

/**
 * Опций парсера.
 * Позволяет указать дополнительные параметры для разбора.
 * @author VolkovRA
 */
typedef ParserOptions =
{
	/**
	 * Список досок.
	 * Укажите true, что-бы обработать этот список.
	 */
	@:optional var boards:Bool;
	
	/**
	 * Список уровней.
	 * Укажите true, что-бы обработать этот список.
	 */
	@:optional var levels:Bool;
	
	/**
	 * Список игроков досок.
	 * Укажите true, что-бы обработать этот список.
	 */
	@:optional var players:Bool;
	
	/**
	 * Список прогресса игроков в игре.
	 * Укажите true, что-бы обработать этот список.
	 */
	@:optional var progress:Bool;
}