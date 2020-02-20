package mvc.model.game;

/**
 * Состояние игры.
 * Описывает все возможные состояния, в которых может находиться объект Game.
 * @author VolkovRA
 */
@:enum
abstract GameState(String) {
	
	/**
	 * Игра не загружена.
	 * Для работы с объектом Game, сперва загрузите в него данные игры.
	 */
	var UNLOADED = "unloaded";
	
	/**
	 * Игра загружена и готова к запуску.
	 */
	var READY = "ready";
	
	/**
	 * Игра запущена.
	 */
	var RUNNING = "running";
	
	/**
	 * Уровень пройден.
	 */
	var LEVEL_COMPLETED = "levelCompleted";
	
	/**
	 * Игра завершена.
	 */
	var GAME_OVER = "gameOver";
}