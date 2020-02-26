package volkovRA.openfl.animation;

import openfl.display.Sprite;
import openfl.display.DisplayObject;

/**
 * Анимация.
 * Максимально простейшая, покадровая анимация на основе DisplayObject-ов для удобного и эффективного использования.
 * @author VolkovRA
 */
class Animation extends Sprite 
{
	/**
	 * Перевести любой номер кадра в допустимый диапазон.
	 * Указанный номер кадра возвращается как номер из допустимого диапазона. (1-total)
	 * @param	frame Номер кадра, который может быть вне диапазона.
	 * @param	total Общее количество кадров.
	 */
	static private inline function getFrame(frame:Int, total:Int):Int {
		if (frame > total)
			return frame - Std.int(frame / total) * total;
		if (frame < 1)
			return frame - Std.int(frame / total - 1) * total;
		
		return frame;
	}
	
	/**
	 * Скорость воспроизведения. (Количество кадров в секунду)
	 * Значение не может быть меньше 0.
	 * По умолчанию: 30.
	 */
	public var fps(get, set):Float;
	/**
	 * Зацикленная анимация.
	 * Если true - после завершения кадров на таймлайне анимация автоматически воспроизводится заного, бесконечно повторяясь.
	 * По умолчанию: true. (Зацикленная)
	 */
	public var repeat(get, set):Bool;
	/**
	 * Общее количество кадров. (read-only)
	 * Для изменения таймлайна используйте методы: <code>addFrame()</code> и <code>clear()</code>.
	 * По умолчанию: 0. (Пусто)
	 */
	public var totalFrames(get, never):Int;
	/**
	 * Номер текущего кадра.
	 * Обратите внимание, что отсчёт первого кадра <b>начинается с 1</b>.
	 * По умолчанию: 0. (Нет кадра)
	 */
	public var currentFrame(get, set):Int;
	
	// Приват
	private var _fs:Float			= 1 / 30;	// Время на один кадр. (sec)
	private var _fps:Float			= 30;		// Кадров в сек.
	private var _time:Float			= 0;		// Прошедшее время с последнего обновления.
	private var _repeat:Bool		= true;
	private var _totalFrames:Int	= 0;
	private var _currentFrame:Int	= 0;
	private var _frames:Array<DisplayObject> = new Array();
	
	/**
	 * Создать покадровую анимацию.
	 */
	public function new() {
		super();
	}
	
	/**
	 * Передать прошедшее время. (sec)
	 * Функция используется для воспроизведения анимации.
	 * Вы можете передать отрицательное значение, что-бы инвертировать анимацию.
	 * @param	passedTime Прошедшее время. (sec)
	 */
	public function advanceTime(passedTime:Float):Void {
		if (_fs == 0)
			return;
		if (_totalFrames < 2)
			return;
		
		// Обновление
		// Время на кадре:
		_time += passedTime;
		
		// Обработка, если есть полный кадр:
		var full = _time / _fs;
		if (full >= 1) {
			var frame = _currentFrame + Std.int(full);
			if (frame > _totalFrames) {
				if (_repeat) {
					frame = getFrame(frame, _totalFrames);
					
					_currentFrame = frame;
					_time -= full * _fs;
					
					removeChildren();
					
					if (_frames[frame-1] != null)
						addChild(_frames[frame-1]);
				}
				else {
					if (_currentFrame < _totalFrames) {
						_currentFrame = _totalFrames;
						_time = _time - full * _fs;
						
						removeChildren();
						
						if (_frames[frame-1] != null)
							addChild(_frames[frame-1]);
					}
					
					if (_time > _fs)
						_time = _fs;
				}
			}
			else {
				_currentFrame = frame;
				_time -= full * _fs;
				
				removeChildren();
				
				if (_frames[frame-1] != null)
					addChild(_frames[frame-1]);
			}
			
			return;
		}
		if (full <= -1) {
			var frame = _currentFrame + Std.int(full);
			if (frame < 1) {
				if (_repeat) {
					frame = getFrame(frame, _totalFrames);
					
					_currentFrame = frame;
					_time -= full * _fs;
					
					removeChildren();
					
					if (_frames[frame-1] != null)
						addChild(_frames[frame-1]);
				}
				else {
					if (_currentFrame > 1) {
						_currentFrame = 1;
						_time = _time - full * _fs;
						
						removeChildren();
						
						if (_frames[frame-1] != null)
							addChild(_frames[frame-1]);
					}
					
					if (_time < -_fs)
						_time = -_fs;
				}
			}
			else {
				_currentFrame = frame;
				_time -= full * _fs;
				
				removeChildren();
				
				if (_frames[frame-1] != null)
					addChild(_frames[frame-1]);
			}
			
			return;
		}
	}
	/**
	 * Добавить кадр.
	 * Новый кадр добавляется в конец таймлайна, если передан null - будет добавлен пустой кадр.
	 * @param	frame Кадр.
	 */
	public function addFrame(frame:DisplayObject):Void {
		if (_totalFrames == 0) {
			_totalFrames	= 1;
			_currentFrame	= 1;
			_time			= 0;
			
			_frames.push(frame);
			
			if (frame != null)
				addChild(frame);
		}
		else {
			_totalFrames ++;
			_frames.push(frame);
		}
	}
	/**
	 * Удалить все кадры.
	 * Полностью очищает таймлайн, приводя его в исходное состояние.
	 */
	public function clear():Void {
		_time		= 0;
		_frames		= new Array();
		removeChildren();
	}
	
	// ГЕТТЕРЫ
	function get_fps():Float {
		return _fps;
	}
	function get_repeat():Bool {
		return _repeat;
	}
	function get_totalFrames():Int {
		return _totalFrames;
	}
	function get_currentFrame():Int {
		return _currentFrame;
	}
	
	// СЕТТЕРЫ
	function set_fps(value:Float):Float {
		if (value == _fps)
			return value;
		
		if (value > 0) {
			_fps	= value;
			_fs		= 1 / value;
		}
		else {
			_fps	= 0;
			_fs		= 0;
		}
		
		return value;
	}
	function set_currentFrame(value:Int):Int {
		_time		= 0;
		
		if (_totalFrames == 0)
			return value;
		
		var frame	= value;
		if (frame > _totalFrames)
			frame	= _totalFrames;
		else if (frame < 1)
			frame	= 1;
		
		if (frame == _currentFrame)
			return value;
		
		removeChildren();
		
		if (_frames[frame-1] != null)
			addChild(_frames[frame-1]);
		
		return value;
	}
	function set_repeat(value:Bool):Bool {
		_repeat = value;
		return value;
	}
}