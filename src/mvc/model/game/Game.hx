package mvc.model.game;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.field.Board;

/**
 * Запущенная игра.
 * Класс описывает экземпляр одной запущенной игры в рантайме, предоставляет API (методы) для работы с ней.
 * @author VolkovRA
 */
class Game extends AModel 
{
	/**
	 * Игровая доска.
	 * Для работы с доской используйте методы класса Game, что-бы играть по правилам!
	 * Не может быть null.
	 */
	public var board(default, null):Board = null;
	
	/**
	 * Количество сделанных ходов на данном уровне.
	 * Один ход - это одно переворачивание фишки на доске.
	 * По умолчанию: 0.
	 */
	public var flips(default, null):Int = 0;
	
	/**
	 * Набранные очки.
	 * Начисляются за успешное прохождение уровней.
	 * По умолчанию: 0.
	 */
	public var score(default, null):Float = 0;
	
	/**
	 * Рекорд по очкам.
	 * Самое лучшее, чего вы достигли в этой жизни.
	 * По умолчанию: 0.
	 */
	public var scoreMax(default, null):Float = 0;
	
	/**
	 * Бонус к очкам на этом уровне.
	 * Вы получаете бонус, если успешно завершаете уровень.
	 * С каждым ходом бонус уменьшается.
	 * По умолчанию: 0.
	 */
	public var bonus(default, null):Float = 0;
	
	/**
	 * Номер текущего уровня. (Где 1 - первый уровень)
	 * По умолчанию: 0. (Уровень не определён)
	 */
	public var level(default, null):Int = 0;
	
	/**
	 * Создать новую игру.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
		
		board = new Board(model);
	}
}