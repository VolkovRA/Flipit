package mvc.model.game;

import openfl.events.Event;
import openfl.events.EventType;

/**
 * Событие запущенной игры.
 * @author VolkovRA
 */
class GameEvent extends Event 
{
	/**
	 * Состояние игры изменилось.
	 */
	public static inline var STATE:EventType<GameEvent>			= "gameState";
	
	/**
	 * Запуск нового уровня.
	 * Событие диспетчерезируется, когда запускается новый игровой уровень.
	 */
	public static inline var LEVEL_START:EventType<GameEvent>	= "gameLevelStart";
	
	/**
	 * Счётчик сделанных ходов изменился.
	 */
	public static inline var FLIPS:EventType<GameEvent>			= "gameFlips";
	
	/**
	 * Количество набранных очков изменилось.
	 */
	public static inline var SCORE:EventType<GameEvent>			= "gameScore";
	
	/**
	 * Максимаьное количество набранных очков изменилось.
	 */
	public static inline var SCORE_MAX:EventType<GameEvent>		= "gameScoreMax";
	
	/**
	 * Значение бонуса изменилось.
	 */
	public static inline var BONUS:EventType<GameEvent>			= "gameBonus";
	
	/**
	 * Создать событие.
	 * @param	type Тип события.
	 */
	public function new(type:String) {
		super(type);
	}
}