package mvc.model.field;

import haxe.ds.Vector;
import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.board.BoardEvent;
import mvc.model.board.ChipState;
import openfl.errors.Error;

/**
 * Игровая доска с фишками.
 * Фишка - это просто значение ChipState на игровом поле (Двумерном массиве).
 * @author VolkovRA
 */
class Board extends AModel 
{
	/**
	 * Размер игровой доски по ширине. (Количество фишек)
	 * По умолчанию: 0.
	 */
	public var width(default, null):Int = 0;
	
	/**
	 * Размер игровой доски по высоте. (Количество фишек)
	 * По умолчанию: 0.
	 */
	public var height(default, null):Int = 0;
	
	/**
	 * Диспетчерезация событий.
	 * Если false, объект не будет генерировать события при изменений своей структуры. (Например, для оптимизации загрузки)
	 * По умолчанию: true. (Рассылать события)
	 */
	public var dispatch:Bool = true;
	
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
	 * Установить размер игровой доски.
	 * Вызов этого метода сбрасывает все текущие фишки, аналогично вызову метода: reset().
	 * @param	width Новый размер игрового поля по ширине.
	 * @param	height Новый размер игрового поля по высоте.
	 * @param	state Состояние фишек.
	 * @eventType mvc.model.board.BoardEvent.SIZE
	 * @eventType mvc.model.board.BoardEvent.RESET
	 */
	public function setSize(width:Int, height:Int, state:ChipState = ChipState.BLACK):Void {
		if (width <= 0)		throw new Error("Корректный размер игровой доски по ширине должен начинаться с 1, width=" + width);
		if (height <= 0)	throw new Error("Корректный размер игровой доски по высоте должен начинаться с 1, height=" + height);
		
		_chips = new Vector<Vector<ChipState>>(width);
		
		for (i in 0..._chips.length) {
			var vec = new Vector<ChipState>(height);
			
			_chips[i] = vec;
			
			for (j in 0...vec.length)
				vec[j] = state;
		}
		
		this.width = width;
		this.height = height;
		
		if (dispatch) {
			dispatchEvent(new BoardEvent(BoardEvent.SIZE));
			dispatchEvent(new BoardEvent(BoardEvent.RESET));
		}
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
		
		if (dispatch) {
			var e = new BoardEvent(BoardEvent.CHIP_STATE);
			e.x = x;
			e.y = y;
			dispatchEvent(e);
		}
		
		return true;
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
	 * Сбросить игровое поле.
	 * Все фишки на игровом поле принимают указанное значение state.
	 * @param	state Новое состояние фишек.
	 * @eventType mvc.model.board.BoardEvent.RESET
	 */
	public function reset(state:ChipState = ChipState.BLACK):Void {
		if (width == 0)
			return;
		
		for (i in 0..._chips.length) {
			for (j in 0..._chips[i].length)
				_chips[i][j] = state;
		}
		
		if (dispatch)
			dispatchEvent(new BoardEvent(BoardEvent.RESET));
	}
}