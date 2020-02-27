package mvc.model.game;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.board.Board;
import mvc.model.data.GameData;
import mvc.model.data.level.LevelData.LevelID;
import mvc.model.data.player.PlayerData;
import mvc.model.data.progress.ProgressData;
import openfl.errors.Error;

/**
 * Запущенная игра.
 * Класс описывает экземпляр одной запущенной игры в рантайме и предоставляет API (методы) для работы с ней.
 * По сути это - ядро игры.
 * @author VolkovRA
 */
class Game extends AModel 
{
	/**
	 * Уменьшение бонуса за каждый ход в игре.
	 */
	static public inline var BONUS_FLIP_DECREASE:Float			= 10;
	/**
	 * Бонус очков за каждый пройденный уровень.
	 */
	static public inline var BONUS_LEVEL_COMPLETED:Float		= 100;
	
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
	 * Не может быть меньше 0.
	 * По умолчанию: 0.
	 */
	public var score(get, set):Float;
	/**
	 * Рекорд по очкам.
	 * Содержит максимальное количество набранных очков игроком за всё время игры.
	 * Не может быть меньше 0.
	 * По умолчанию: 0.
	 */
	public var highest(get, set):Float;
	/**
	 * Бонус к очкам на этом уровне.
	 * Вы получаете бонус, если успешно завершаете уровень.
	 * С каждым ходом бонус уменьшается.
	 * По умолчанию: 0.
	 */
	public var bonus(get, set):Float;
	/**
	 * ID Игрока.
	 * Указывает на игрока, играющего в эту игру.
	 * По умолчанию: 0.
	 */
	public var player(get, never):PlayerID;
	
	// Приват:
	private var _state:GameState		= GameState.UNLOADED;
	private var _level:LevelID			= 0;
	private var _flips:Int				= 0;
	private var _bonus:Float			= 0;
	private var _score:Float			= 0;
	private var _highest:Float			= 0;
	private var _player:PlayerID		= 0;
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
	 * После успешной загрузки объект Game переходит в состояние: GameState.LOADED.
	 * Все несохранённые данные удаляются.
	 * @param	data Игровые данные.
	 * @param	player ID Игрока из данных игры.
	 */
	public function load(data:GameData, player:PlayerID):Void {
		if (data == null)
			throw new Error("Игровые данные не должны быть null");
		if (player == null || player == 0)
			throw new Error("ID Игрока не должен быть null или 0");
		
		var playerData	= data.players.getItemByID(player);
		
		_data			= data;
		_state			= GameState.LOADED;
		_player			= player;
		_level			= 0;
		
		board.clear();
		
		highest			= playerData == null ? 0 : playerData.highest;
		score			= 0;
		flips			= 0;
		bonus			= 0;
		
		dispatchEvent(new GameEvent(GameEvent.LOADED));
	}
	/**
	 * Выгрузить данные.
	 * Все несохранённые данные будут потеряны, возвращает объект в исходное состояние.
	 */
	public function unload():Void {
		if (_state == GameState.UNLOADED)
			return;
		
		_state			= GameState.UNLOADED;
		_data			= null;
		_player			= 0;
		_level			= 0;
		
		board.clear();
		
		bonus			= 0;
		flips			= 0;
		score			= 0;
		highest			= 0;
		
		dispatchEvent(new GameEvent(GameEvent.UNLOADED));
	}
	/**
	 * Запустить новую игру.
	 * Сохранённый прогресс удаляется и начинается новая игра с указанного уровня.
	 * @param	level ID Игрового уровня.
	 */
	public function startGame(level:LevelID):Void {
		if (_state == GameState.UNLOADED)
			throw new Error("Данные игры не загружены");
		
		// Данные уровня:
		var levelData	= _data.levels.getItemByID(level);
		if (levelData == null)
			throw new Error("Отсутствуют данные игрового уровня для level=" + level);
		
		// Доска:
		var boardData	= _data.boards.getBoardByLevel(level);
		if (boardData == null)
			throw new Error("Отсутствуют данные игровой доски для уровня level=" + level);
		
		// Всё пучком, запускаем новую игру:
		_state			= GameState.RUNNING;
		_level			= level;
		
		board.setBoardData(boardData);
		
		bonus			= levelData.bonus;
		score			= 0;
		flips			= 0;
		
		dispatchEvent(new GameEvent(GameEvent.LEVEL_START));
	}
	/**
	 * Запустить следующий уровень.
	 * Вызов этого метода запускает следующий уровень в игре, текущий уровень при этом должен быть пройден!
	 */
	public function nextLevel():Void {
		if (_state != GameState.COMPLETED)
			throw new Error("Для перехода на следующий уровень необходимо пройти текущий");
		
		// Текущий уровень:
		var levelData	= _data.levels.getItemByID(_level);
		if (levelData == null)
			throw new Error("Отсутствуют данные текущего игрового уровня level=" + _level);
		
		// Следующий уровень:
		var nextLevel	= _data.levels.getNextLevel(levelData.num);
		if (nextLevel == null)
			throw new Error("Отсутствуют данные для следующего за этим игрового уровня level=" + _level);
		
		// Доска:
		var boardData	= _data.boards.getBoardByLevel(nextLevel.id);
		if (boardData == null)
			throw new Error("Отсутствуют данные игровой доски для уровня level=" + nextLevel.id);
		
		// Всё пучком, запускаем новую игру:
		_state			= GameState.RUNNING;
		_level			= nextLevel.id;
		
		board.setBoardData(boardData);
		
		bonus			= nextLevel.bonus;
		flips			= 0;
		
		dispatchEvent(new GameEvent(GameEvent.LEVEL_START));
	}
	/**
	 * Начать уровень заного.
	 * Перезапускает текущий уровень.
	 */
	public function reset():Void {
		if (_state == GameState.UNLOADED)
			throw new Error("Данные игры не загружены");
		if (_level == 0)
			throw new Error("Уровень не запущен");
		
		// Данные уровня:
		var levelData	= _data.levels.getItemByID(level);
		if (levelData == null)
			throw new Error("Отсутствуют данные текущего игрового уровня level=" + level);
		
		// Доска:
		var boardData	= _data.boards.getBoardByLevel(level);
		if (boardData == null)
			throw new Error("Отсутствуют данные игровой доски для уровня level=" + level);
		
		// Перезапускаем:
		_state			= GameState.RUNNING;
		
		board.setBoardData(boardData);
		
		bonus			= levelData.bonus;
		flips			= 0;
		
		dispatchEvent(new GameEvent(GameEvent.LEVEL_START));
	}
	/**
	 * Сделать ход.
	 * Метод доступен только для запущенной игры.
	 * @param	x Позиция фишки по X.
	 * @param	y Позиция фишки по Y.
	 */
	public function step(x:Int, y:Int):Void {
		if (_state != GameState.RUNNING)
			throw new Error("Игра не запущена");
		
		board.changeChip(x, y);
		board.changeChip(x-1, y);
		board.changeChip(x+1, y);
		board.changeChip(x, y-1);
		board.changeChip(x, y + 1);
		
		bonus -= BONUS_FLIP_DECREASE;
		flips ++;
		
		dispatchEvent(new GameEvent(GameEvent.STEP));
		
		// Проверка на победу:
		if (board.checkWin()) {
			_state				= GameState.COMPLETED;
			score				+= BONUS_LEVEL_COMPLETED + bonus;
			highest				= score > highest ? score : highest;
			
			// Прогресс игрока
			// Игрок:
			var pData			= _data.players.getItemByID(_player);
			if (pData == null) {
				pData			= new PlayerData();
				pData.id		= _player;
				_data.players.add(pData);
			}
			pData.highest		= highest;
			
			// Уровень:
			var prData			= _data.progress.getPlayerOfLevel(_player, _level);
			if (prData == null) {
				prData			= new ProgressData();
				prData.id		= _data.progress.maxID + 1;
				prData.level	= _level;
				prData.player	= _player;
			}
			prData.completed	= true;
			
			// Событие победы:
			dispatchEvent(new GameEvent(GameEvent.LEVEL_COMPLETED));
		}
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
	function get_highest():Float {
		return _highest;
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
	function get_player():PlayerID {
		return _player;
	}
	
	// СЕТТЕРЫ
	function set_flips(value:Int):Int {
		var v:Int = 0;
		if (value > 0)
			v = value;
		
		if (v == _flips)
			return value;
		
		_flips = v;
		dispatchEvent(new GameEvent(GameEvent.FLIPS));
		
		return value;
	}
	function set_bonus(value:Float):Float {
		var v:Float = 0;
		if (value > 0)
			v = value;
		
		if (v == _bonus)
			return value;
		
		_bonus = v;
		dispatchEvent(new GameEvent(GameEvent.BONUS));
		
		return value;
	}
	function set_score(value:Float):Float {
		var v:Float = 0;
		if (value > 0)
			v = value;
		if (v == _score)
			return value;
		
		_score = v;
		dispatchEvent(new GameEvent(GameEvent.SCORE));
		
		return value;
	}
	function set_highest(value:Float):Float {
		var v:Float = 0;
		if (value > 0)
			v = value;
		if (v == _highest)
			return value;
		
		_highest = v;
		dispatchEvent(new GameEvent(GameEvent.HIGHEST));
		
		return value;
	}
}