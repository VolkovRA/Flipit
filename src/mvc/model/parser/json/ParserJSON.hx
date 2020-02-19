package mvc.model.parser.json;

import haxe.DynamicAccess;
import haxe.Json;
import haxe.ds.Vector;
import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.board.ChipState;
import mvc.model.data.GameData;
import mvc.model.data.board.BoardData;
import mvc.model.data.level.LevelData;
import openfl.errors.Error;

/**
 * Парсер игровых данных из формата JSON.
 * @author VolkovRA
 */
class ParserJSON extends AModel 
{
	static private inline var KEY_LEVELS:String		= "levels";
	static private inline var KEY_BOARDS:String		= "boards";
	
	/**
	 * Создать парсер.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
	}
	
	/**
	 * Прочитать игровые данные из формата JSON.
	 * Считывает данные из переданной строки и записывает их в указанный объект GameData, либо создаёт новый, если он не передан.
	 * Переданный объект GameData очищается. (Вызов clear())
	 * @param	str Строка игровых данных в формате JSON.
	 * @param	to Объект для записи, если null - создаётся новый объект.
	 * @return	Прочитанные, игровые данные.
	 */
	public function read(str:String, to:GameData = null):GameData {
		if (str == null)
			throw new Error("Игровые данные для разбора не должны быть null");
		if (to == null)
			to = new GameData(model);
		
		// Парсим:
		var data:DynamicAccess<Dynamic> = null;
		try {
			data = Json.parse(str);
			str = null; // <- Чтоб не занимал память
		}
		catch (err:Dynamic) {
			throw new Error("Ошибка чтения игровых данных - невалидный JSON\n" + Std.string(err));
		}
		
		// Чтение списков:
		if (data.exists(KEY_LEVELS))		readLevelList(data[KEY_LEVELS], to);
		if (data.exists(KEY_BOARDS))		readBoardList(data[KEY_BOARDS], to);
		
		return to;
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
		
		var width:Int = arr.length;
		if (width <= 0)
			throw new Error("Игровая доска: id=" + item.id + " не должна быть пустой");
		
		// Получаем размеры:
		var arr2:Array<Int> = arr[0];
		if (!Std.is(arr2, Array))
			throw new Error("Некорректное описание расположения фишек на игровой доске: id=" + item.id + ", ожидался массив с Int, получено: " + arr2);
		
		var height:Int = arr2.length;
		if (height <= 0)
			throw new Error("Игровая доска: id=" + item.id + " не должна быть пустой");
		
		// Создаём доску:
		var vec:Vector<Vector<ChipState>> = new Vector(width);
		
		// Читаем и заполняем доску:
		var x:Int = 0;
		while (x < width) {
			arr2 = arr[x];
			
			if (!Std.is(arr2, Array))
				throw new Error("Некорректный формат расположения фишек на игровой доске: id=" + item.id + ", ожидался массив, получено: " + arr2);
			
			var length = arr2.length;
			if (length != height)
				throw new Error("Некорректное описание фишек на игровой доске: id=" + item.id + ", размер всех линий на доске должен быть одинаковым. Линия: " + x + ", ожидаемая длина: " + height + ", получено: " + length);
			
			var vec2:Vector<ChipState> = new Vector(height);
			var y:Int = 0;
			while (y < height) {
				vec2[y] = readChipState(arr2[y]);
				y ++;
			}
			
			vec[x] = vec2;
			x ++;
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
}