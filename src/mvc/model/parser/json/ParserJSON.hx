package mvc.model.parser.json;

import haxe.DynamicAccess;
import haxe.Json;
import haxe.ds.Vector;
import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.chip.ChipState;
import mvc.model.data.GameData;
import mvc.model.data.board.BoardData;
import mvc.model.data.board.BoardDataList;
import mvc.model.data.level.LevelData;
import mvc.model.data.level.LevelDataList;
import mvc.model.data.player.PlayerData;
import mvc.model.data.player.PlayerDataList;
import mvc.model.data.progress.ProgressData;
import mvc.model.data.progress.ProgressDataList;
import openfl.errors.Error;

/**
 * Парсер игровых данных из формата JSON.
 * @author VolkovRA
 */
class ParserJSON extends AModel implements IParser
{
	static private inline var KEY_VERSION:String		= "version";
	static private inline var KEY_LEVELS:String			= "levels";
	static private inline var KEY_BOARDS:String			= "boards";
	static private inline var KEY_PLAYERS:String		= "players";
	static private inline var KEY_PROGRESS:String		= "progress";
	
	/**
	 * Создать парсер.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
	}
	
	// АПИ
	public function read(str:String, to:GameData = null, options:ParserOptions = null):GameData {
		if (str == null)
			throw new Error("Игровые данные для чтения не должны быть null");
		if (to == null)
			to = new GameData(model);
		
		// Парсим:
		var data:DynamicAccess<Dynamic> = null;
		try {
			data = Json.parse(str);
			str = null; // <- Чтоб не занимал память
		}
		catch (err:Dynamic) {
			throw new Error("Ошибка чтения игровых данных, невалидный JSON\n" + Std.string(err));
		}
		
		// Проверка версии:
		if (!data.exists(KEY_VERSION))
			throw new Error("Ошибка чтения игровых данных, отсутствуют данные версии (" + KEY_VERSION + ")");
		
		var version:Version = Version.fromString(data[KEY_VERSION]);
		if (version.major < Settings.VERSION.major)
			throw new Error("Ошибка чтения игровых данных, версия загружаемых данных устарела и не совместима с текущей версией игры");
		
		// Чтение списков:
		if (options == null) {
			if (data.exists(KEY_LEVELS))		readLevelList(data[KEY_LEVELS], to);
			if (data.exists(KEY_BOARDS))		readBoardList(data[KEY_BOARDS], to);
			if (data.exists(KEY_PLAYERS))		readPlayerList(data[KEY_PLAYERS], to);
			if (data.exists(KEY_PROGRESS))		readProgressList(data[KEY_PROGRESS], to);
		}
		else {
			if (options.levels && data.exists(KEY_LEVELS))			readLevelList(data[KEY_LEVELS], to);
			if (options.boards && data.exists(KEY_BOARDS))			readBoardList(data[KEY_BOARDS], to);
			if (options.players && data.exists(KEY_PLAYERS))		readPlayerList(data[KEY_PLAYERS], to);
			if (options.progress && data.exists(KEY_PROGRESS))		readProgressList(data[KEY_PROGRESS], to);
		}
		
		return to;
	}
	public function write(data:GameData, options:ParserOptions = null):String {
		if (data == null)
			throw new Error("Игровые данные для записи не должны быть null");
		
		var obj:DynamicAccess<Dynamic> = {};
		
		// Запись версии:
		obj[KEY_VERSION] = Settings.VERSION.toString();
		
		// Запись списков:
		if (options == null) {
			obj[KEY_LEVELS]			= writeLevelList(data.levels);
			obj[KEY_BOARDS]			= writeBoardList(data.boards);
			obj[KEY_PLAYERS]		= writePlayerList(data.players);
			obj[KEY_PROGRESS]		= writeProgressList(data.progress);
		}
		else {
			if (options.levels)		obj[KEY_LEVELS] = writeLevelList(data.levels);
			if (options.boards)		obj[KEY_BOARDS] = writeBoardList(data.boards);
			if (options.players)	obj[KEY_PLAYERS] = writePlayerList(data.players);
			if (options.progress)	obj[KEY_PROGRESS] = writeProgressList(data.progress);
		}
		
		return Json.stringify(obj);
	}
	
	// ЧТЕНИЕ
	// Уровни:
	private function readLevelList(arr:Array<Dynamic>, to:GameData):Void {
		if (!Std.is(arr, Array))
			throw new Error("Невалидное значение списка игровых уровней (" + KEY_LEVELS + "), ожидался массив, получено: " + Std.string(arr));
		
		var i = arr.length;
		while (i-- > 0)
			to.levels.add(readLevel(arr[i]));
	}
	private function readLevel(data:DynamicAccess<Dynamic>):LevelData {
		if (data == null)
			throw new Error("Данные игрового уровня не должны быть null");
			
		var item		= new LevelData();
		item.id			= data["id"];
		item.num		= data["num"];
		item.bonus		= data["bonus"];
		
		return item;
	}
	// Доски:
	private function readBoardList(arr:Array<Dynamic>, to:GameData):Void {
		if (!Std.is(arr, Array))
			throw new Error("Невалидное значение списка игровых досок (" + KEY_BOARDS + "), ожидался массив, получено: " + Std.string(arr));
		
		var i = arr.length;
		while (i-- > 0)
			to.boards.add(readBoard(arr[i]));
	}
	private function readBoard(data:DynamicAccess<Dynamic>):BoardData {
		if (data == null)
			throw new Error("Данные игровой доски не должны быть null");
		
		var item		= new BoardData();
		item.id			= data["id"];
		item.level		= data["level"];
		
		// Считываем расположение фишек.
		// Расположение фишек на доске:
		var arr:Array<Array<Int>> = data["data"];
		if (!Std.is(arr, Array))
			throw new Error("Некорректное описание расположения фишек на игровой доске: id=" + item.id + ", ожидался массив массивов с Int, получено: " + arr);
		
		var height:Int = arr.length;
		if (height <= 0)
			throw new Error("Игровая доска: id=" + item.id + " не должна быть пустой");
		
		// Получаем размеры:
		if (!Std.is(arr[0], Array))
			throw new Error("Некорректное описание расположения фишек на игровой доске: id=" + item.id + ", ожидался массив с Int, получено: " + arr[0]);
		
		var width:Int = arr[0].length;
		if (width <= 0)
			throw new Error("Игровая доска: id=" + item.id + " не должна быть пустой");
		
		// Создаём доску:
		var vec:Vector<Vector<ChipState>> = new Vector(width);
		
		// Читаем и заполняем доску: (В данных JSON x и y инвертированы)
		var y:Int = 0;
		while (y < height) {
			var line = arr[y];
			if (!Std.is(line, Array))
				throw new Error("Некорректный формат расположения фишек на игровой доске: id=" + item.id + ", ожидался массив, получено: " + line);
			if (line.length != width)
				throw new Error("Некорректное описание фишек на игровой доске: id=" + item.id + ", размер всех линий на доске должен быть одинаковым. Линия: " + y + ", ожидаемая длина: " + width + ", получено: " + line.length);
			
			var x:Int = 0;
			while (x < width) {
				var vec2 = vec[x];
				if (vec2 == null) {
					vec2	= new Vector<ChipState>(height);
					vec[x]	= vec2;
				}
				
				vec2[y] = readChipState(line[x]);
				x ++;
			}
			
			y ++;
		}
		
		// Если код выше упадёт, некорректные изменения не будут внесены:
		item.data = vec;
		
		return item;
	}
	// Фишки:
	private function readChipState(state:Int):ChipState {
		if (state == 0)		return ChipState.BLACK;
		if (state == 1)		return ChipState.WHITE;
		
		throw new Error("Некорректное значение состояния фишки на игровой доске. Допустимые значения: 0, 1. Получено: " + state);
	}
	// Игроки:
	private function readPlayerList(arr:Array<Dynamic>, to:GameData):Void {
		if (!Std.is(arr, Array))
			throw new Error("Невалидное значение списка данных игроков (" + KEY_PLAYERS + "), ожидался массив, получено: " + Std.string(arr));
		
		var i = arr.length;
		while (i-- > 0)
			to.players.add(readPlayer(arr[i]));
	}
	private function readPlayer(data:DynamicAccess<Dynamic>):PlayerData {
		if (data == null)
			throw new Error("Данные игрока не должны быть null");
			
		var item		= new PlayerData();
		item.id			= data["id"];
		item.name		= data["name"];
		item.highest	= data["highest"];
		
		return item;
	}
	// Прогресс:
	private function readProgressList(arr:Array<Dynamic>, to:GameData):Void {
		if (!Std.is(arr, Array))
			throw new Error("Невалидное значение списка прогресса прохождения (" + KEY_PROGRESS + "), ожидался массив, получено: " + Std.string(arr));
		
		var i = arr.length;
		while (i-- > 0)
			to.progress.add(readProgress(arr[i]));
	}
	private function readProgress(data:DynamicAccess<Dynamic>):ProgressData {
		if (data == null)
			throw new Error("Данные прогресса прохождения не должны быть null");
			
		var item		= new ProgressData();
		item.id			= data["id"];
		item.level		= data["level"];
		item.player		= data["player"];
		item.completed	= readBool(data["completed"]);
		
		return item;
	}
	// Разное:
	private function readBool(value:Dynamic):Bool {
		if (value == 1)
			return true;
		else
			return false;
	}
	
	// ЗАПИСЬ
	// Уровни:
	private function writeLevelList(list:LevelDataList):Array<DynamicAccess<Dynamic>> {
		var arr:Array<DynamicAccess<Dynamic>> = new Array();
		
		for (item in list)
			arr.push(writeLevel(item));
		
		return arr;
	}
	private function writeLevel(item:LevelData):DynamicAccess<Dynamic> {
		var data:DynamicAccess<Dynamic> = {};
		data["id"]			= item.id;
		data["num"]			= item.num;
		data["bonus"]		= item.bonus;
		
		return data;
	}
	// Доски:
	private function writeBoardList(list:BoardDataList):Array<DynamicAccess<Dynamic>> {
		var arr:Array<DynamicAccess<Dynamic>> = new Array();
		
		for (item in list)
			arr.push(writeBoard(item));
		
		return arr;
	}
	private function writeBoard(item:BoardData):DynamicAccess<Dynamic> {
		throw new Error("Функционал не реализован");
	}
	// Игроки:
	private function writePlayerList(list:PlayerDataList):Array<DynamicAccess<Dynamic>> {
		var arr:Array<DynamicAccess<Dynamic>> = new Array();
		
		for (item in list)
			arr.push(writePlayer(item));
		
		return arr;
	}
	private function writePlayer(item:PlayerData):DynamicAccess<Dynamic> {
		var data:DynamicAccess<Dynamic> = {};
		data["id"]			= item.id;
		data["name"]		= item.name;
		data["highest"]		= item.highest;
		
		return data;
	}
	// Прогресс:
	private function writeProgressList(list:ProgressDataList):Array<DynamicAccess<Dynamic>> {
		var arr:Array<DynamicAccess<Dynamic>> = new Array();
		
		for (item in list)
			arr.push(writeProgress(item));
		
		return arr;
	}
	private function writeProgress(item:ProgressData):DynamicAccess<Dynamic> {
		var data:DynamicAccess<Dynamic> = {};
		data["id"]			= item.id;
		data["level"]		= item.level;
		data["player"]		= item.player;
		data["completed"]	= writeBool(item.completed);
		
		return data;
	}
	// Разное:
	private function writeBool(value:Bool):Int {
		if (value)
			return 1;
		else
			return 0;
	}
}