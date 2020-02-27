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
	 * Игра загружена.
	 * Событие диспетчерезируется при вызове метода: <code>Game.load()</code>.
	 * В этот момент доступны данные игры, ID игрока.
	 * Состояние игры: GameState.LOADED.
	 */
	public static inline var LOADED:EventType<GameEvent>			= "gameLoaded";
	/**
	 * Игра выгружена.
	 * Событие диспетчерезируется при вызове метода: <code>Game.unload()</code>.
	 * В этот момент все данные уже не доступны.
	 * Состояние игры: GameState.UNLOADED.
	 */
	public static inline var UNLOADED:EventType<GameEvent>			= "gameUnloaded";
	/**
	 * Запуск нового уровня.
	 * Событие диспетчерезируется, когда запускается новый игровой уровень.
	 * Состояние игры: GameState.RUNNING.
	 */
	public static inline var LEVEL_START:EventType<GameEvent>		= "gameLevelStart";
	/**
	 * Уровень пройден!
	 * Событие диспетчерезируется, когда игровой уровень был успешно пройден. (Пазл собран)
	 * Состояние игры: GameState.COMPLETED.
	 */
	public static inline var LEVEL_COMPLETED:EventType<GameEvent>	= "gameLevelCompleted";
	/**
	 * Игровой ход.
	 * Событие диспетчерезируется каждый раз, когда игрок делает ход в игре.
	 */
	public static inline var STEP:EventType<GameEvent>				= "gameStep";
	/**
	 * Счётчик сделанных ходов изменился.
	 */
	public static inline var FLIPS:EventType<GameEvent>				= "gameFlips";
	/**
	 * Количество набранных очков изменилось.
	 */
	public static inline var SCORE:EventType<GameEvent>				= "gameScore";
	/**
	 * Максимальное количество набранных очков изменилось.
	 */
	public static inline var HIGHEST:EventType<GameEvent>			= "gameHighest";
	/**
	 * Значение бонуса изменилось.
	 */
	public static inline var BONUS:EventType<GameEvent>				= "gameBonus";
	
	/**
	 * Создать событие.
	 * @param	type Тип события.
	 */
	public function new(type:String) {
		super(type);
	}
}