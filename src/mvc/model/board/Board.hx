package mvc.model.board;

import haxe.ds.Vector;
import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.board.BoardEvent;
import mvc.model.chip.ChipState;
import mvc.model.data.board.BoardData;
import openfl.errors.Error;

/**
 * Игровая доска с фишками.
 * Фишка - это просто значение ChipState на игровом поле (Двумерном массиве).
 * @author VolkovRA
 */
class Board extends AModel 
{
	/**
	 * Размер игровой доски по ширине. (Количество фишек по горизонтали)
	 * По умолчанию: 0.
	 */
	public var width(default, null):Int = 0;
	
	/**
	 * Размер игровой доски по высоте. (Количество фишек по вертикали)
	 * По умолчанию: 0.
	 */
	public var height(default, null):Int = 0;
	
	// Приват:
	private var _chips:Vector<Vector<ChipState>> = null;
	
	/**
	 * Создать игровую доску.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);	
	}
	
	/**
	 * Установить новое состояние фишки.
	 * Если указанная фишка уже имеет это состояние, событие не диспетчерезируется.
	 * @param	x Позиция фишки по ширине. (От 0 до width-1)
	 * @param	y Позиция фишки по высоте. (От 0 до height-1)
	 * @param	state Новое состояние фишки.
	 * @return	Возвращает true, если указанная фишка изменила своё состояние.
	 * @eventType mvc.model.board.BoardEvent.CHIP_STATE
	 */
	public function setChip(x:Int, y:Int, state:ChipState):Bool {
		if (x < 0)			throw new Error("Указанная позиция фишки по x=" + x + " не может быть меньше 0");
		if (y < 0)			throw new Error("Указанная позиция фишки по y=" + y + " не может быть меньше 0");
		if (x >= width)		throw new Error("Указанная позиция фишки по x=" + x + " выходит за рамки размеров игрового поля width=" + width);
		if (y >= height)	throw new Error("Указанная позиция фишки по y=" + y + " выходит за рамки размеров игрового поля height=" + height);
		
		if (_chips[x][y] == state)
			return false;
		
		_chips[x][y] = state;
		
		var e = new BoardEvent(BoardEvent.CHIP_STATE);
		e.x = x;
		e.y = y;
		dispatchEvent(e);
		
		return true;
	}
	
	/**
	 * Переключить фишку.
	 * Меняет состояние указанной фишки на противоположное.
	 * Вызов игнорируется, если указанный диапазон x или y выходит за рамки доски.
	 * @param	x Позиция фишки по X.
	 * @param	y Позиция фишки по Y.
	 */
	public function changeChip(x:Int, y:Int):Void {
		if (x < 0)			return;
		if (y < 0)			return;
		if (x >= width)		return;
		if (y >= height)	return;
		
		switch (_chips[x][y]) {
			case ChipState.BLACK:	_chips[x][y] = ChipState.WHITE;
			case ChipState.WHITE:	_chips[x][y] = ChipState.BLACK;
			default:				throw new Error("Неизвестное состояние фишки state=" + _chips[x][y]);
		}
		
		var e = new BoardEvent(BoardEvent.CHIP_STATE);
		e.x = x;
		e.y = y;
		dispatchEvent(e);
	}
	
	/**
	 * Получить состояние фишки.
	 * Возвращает состояние указанной фишки на игровом поле.
	 * @param	x Позиция фишки по ширине. (От 0 до width-1)
	 * @param	y Позиция фишки по высоте. (От 0 до height-1)
	 * @return	Состояние фишки.
	 */
	public function getChip(x:Int, y:Int):ChipState {
		if (x < 0)			throw new Error("Запрошенная позиция фишки по x=" + x + " не может быть меньше 0");
		if (y < 0)			throw new Error("Запрошенная позиция фишки по y=" + x + " не может быть меньше 0");
		if (x >= width)		throw new Error("Запрошенная позиция фишки по x=" + x + " выходит за рамки размеров игрового поля width=" + width);
		if (y >= height)	throw new Error("Запрошенная позиция фишки по y=" + y + " выходит за рамки размеров игрового поля height=" + height);
		
		return _chips[x][y];
	}
	
	/**
	 * Проверить доску на победу.
	 * Возвращает true, если все фишки на доске собраны.
	 */
	public function checkWin():Bool {
		if (width == 0)
			return false;
		if (height == 0)
			return false;
		
		var x = _chips.length;
		while (x-- > 0) {
			var y = _chips[x].length;
			while (y-- > 0) {
				if (_chips[x][y] != Settings.CHIP_STATE_WIN)
					return false;
			}
		}
		
		return true;
	}
	
	/**
	 * Установить доску.
	 * Приводит доску в соответствие с переданными данными, изменяя её размер и состояние фишек.
	 * @param	data Данные игровой доски.
	 * @eventType mvc.model.board.BoardEvent.CHANGE
	 */
	public function setBoardData(board:BoardData):Void {
		if (board == null)
			throw new Error("Данные игровой доски не должны быть null");
		if (board.data == null)
			throw new Error("В переданном объекте данных игровой доски (id=" + board.id + ") нет описания игрового поля с фишками");
		
		width = board.data.length;
		height = board.data[0].length;
		
		_chips = new Vector(width);
		
		var x = width;
		while (x-- > 0) {
			_chips[x] = new Vector(height);
			
			var y = height;
			while (y-- > 0)
				_chips[x][y] = board.data[x][y];
		}
		
		dispatchEvent(new BoardEvent(BoardEvent.CHANGE));
	}
	
	/**
	 * Очистить доску.
	 * Удаляет все фишки на игровой доске, размеры доски становятся: 0x0.
	 * Приводит объект в изначальное состояние.
	 * @eventType mvc.model.board.BoardEvent.CHANGE
	 */
	public function clear():Void {
		width = 0;
		height = 0;
		
		_chips = null;
		
		dispatchEvent(new BoardEvent(BoardEvent.CHANGE));
	}
}