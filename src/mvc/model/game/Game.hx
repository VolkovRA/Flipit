package mvc.model.game;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.board.Board;
import mvc.model.data.GameData;
import mvc.model.data.level.LevelData;
import openfl.errors.Error;

/**
 * Запущенная игра.
 * Класс описывает экземпляр одной запущенной игры в рантайме и предоставляет API (методы) для работы с ней.
 * По сути это - ядро игры.
 * @author VolkovRA
 */
class Game extends AModel 
{
	// КОМПОЗИЦИЯ
	/**
	 * Игровая доска. (read-only)
	 * Для работы с доской используйте методы класса Game, что-бы играть по правилам!
	 * Не может быть null.
	 */
	public var board(default, null):Board;
	
	// СВОЙСТВА
	/**
	 * Данные загруженной игры. (read-only)
	 * Для загрузки данных используйте метод load().
	 * По умолчанию: null.
	 */
	public var data(get, never):GameData;
	/**
	 * Состояние игры. (read-only)
	 * Значение описывает текущее состояние объекта Game.
	 * Оно переключается автоматически при работе с методами API и по ходу течения игры.
	 * При изменении состояния всегда диспетчерезируется событие: GameEvent.STATE.
	 * По умолчанию: GameState.UNLOADED.
	 */
	public var state(get, never):GameState;
	/**
	 * ID Текущего уровня. (read-only)
	 * Изменяется, когда вызывается метод: runLevel().
	 * По умолчанию: 0. (Уровень не запущен)
	 */
	public var level(get, never):LevelID;
	/**
	 * Счётчик ходов на текущем уровне.
	 * Один ход - это одно переворачивание фишки на доске.
	 * При переходе на другой уровень счётчик сбрасывается.
	 * По умолчанию: 0.
	 */
	public var flips(get, set):Int;
	/**
	 * Набранные очки.
	 * Начисляются за успешное прохождение игроком уровней.
	 * По умолчанию: 0.
	 */
	public var score(get, set):Float;
	/**
	 * Рекорд по очкам.
	 * Самое лучшее, чего достиг игрок в этой жизни.
	 * По умолчанию: 0.
	 */
	public var scoreMax(get, set):Float;
	/**
	 * Бонус к очкам на этом уровне.
	 * Вы получаете бонус, если успешно завершаете уровень.
	 * С каждым ходом бонус уменьшается.
	 * По умолчанию: 0.
	 */
	public var bonus(get, set):Float;
	
	// Приват:
	private var _state:GameState		= GameState.UNLOADED;
	private var _level:LevelID			= 0;
	private var _flips:Int				= 0;
	private var _bonus:Float			= 0;
	private var _score:Float			= 0;
	private var _scoreMax:Float			= 0;
	private var _data:GameData			= null;
	
	/**
	 * Создать новую игру.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
		
		board = new Board(model);
	}
	
	// АПИ
	/**
	 * Загрузить данные игры.
	 * После успешной загрузки объект Game переходит в состояние: GameState.READY.
	 * Игра должна находиться в состоянии: GameState.UNLOADED, в противном случае, будет выброшено исключение. Если это не так, сперва выгрузите текущую игру.
	 * @param	data Игровые данные.
	 */
	public function load(data:GameData):Void {
		if (data == null)
			throw new Error("Игровые данные не должны быть null");
		if (_state != GameState.UNLOADED)
			throw new Error("Предыдущая игра не выгружена");
		
		_data			= data;
		_state			= GameState.READY;
		
		dispatchEvent(new GameEvent(GameEvent.STATE));
	}
	
	/**
	 * Выгрузить игру.
	 * Все несохранённые данные будут потеряны.
	 */
	public function unload():Void {
		if (_state == GameState.UNLOADED)
			return;
		
		_data			= null;
		_state			= GameState.UNLOADED;
		_level			= 0;
		
		board.clear();
		
		flips			= 0;
		score			= 0;
		scoreMax		= 0;
		bonus			= 0;
		
		dispatchEvent(new GameEvent(GameEvent.STATE));
	}
	
	/**
	 * Запустить уровень.
	 * Если указанный уровень уже запущен, будет произведён его рестарт.
	 * @param	level ID Игрового уровня.
	 */
	public function runLevel(level:LevelID):Void {
		if (_state == GameState.UNLOADED)
			throw new Error("Данные игры не загружены");
		
		var levelData	= _data.levels.getItemByID(level);
		if (levelData == null)
			throw new Error("Отсутствуют данные игрового уровня для level=" + level);
		
		var boardData	= _data.boards.getBoardByLevel(level);
		if (boardData == null)
			throw new Error("Отсутствуют данные игровой доски для уровня level=" + level);
		
		// Запускаем уровень:
		_state			= GameState.RUNNING;
		_level			= level;
		
		board.setBoardData(boardData);
		
		flips			= 0;
		score			= 0;
		scoreMax		= 0;
		bonus			= 0;
		
		dispatchEvent(new GameEvent(GameEvent.STATE));
		dispatchEvent(new GameEvent(GameEvent.LEVEL_START));
	}
	
	// ГЕТТЕРЫ
	function get_state():GameState {
		return _state;
	}
	function get_flips():Int {
		return _flips;
	}
	function get_score():Float {
		return _score;
	}
	function get_scoreMax():Float {
		return _scoreMax;
	}
	function get_bonus():Float {
		return _bonus;
	}
	function get_level():LevelID {
		return _level;
	}
	function get_data():GameData {
		return _data;
	}
	
	// СЕТТЕРЫ
	function set_flips(value:Int):Int {
		if (value == _flips)
			return value;
		
		_flips = value;
		dispatchEvent(new GameEvent(GameEvent.FLIPS));
		
		return value;
	}
	function set_bonus(value:Float):Float {
		if (value == _bonus)
			return value;
		
		_bonus = value;
		dispatchEvent(new GameEvent(GameEvent.BONUS));
		
		return value;
	}
	function set_score(value:Float):Float {
		if (value == _score)
			return value;
		
		_score = value;
		dispatchEvent(new GameEvent(GameEvent.SCORE));
		
		return value;
	}
	function set_scoreMax(value:Float):Float {
		if (value == _scoreMax)
			return value;
		
		_scoreMax = value;
		dispatchEvent(new GameEvent(GameEvent.SCORE_MAX));
		
		return value;
	}
}