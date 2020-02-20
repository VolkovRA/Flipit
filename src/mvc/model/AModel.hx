package mvc.model;

import openfl.errors.Error;
import openfl.events.EventDispatcher;

/**
 * Модель.
 * Абстрактный, базовый класс всех игровых моделей.
 * @author VolkovRA
 */
class AModel extends EventDispatcher
{
	/**
	 * Главная модель.
	 * Не может быть null.
	 */
	public var model(default, null):Model = null;
	
	/**
	 * Создать игровую модель.
	 * @param	model Главная, игровая модель.
	 */
	public function new(model:Model) {
		super();
		
		if (model == null)
			throw new Error("Главная модель не должна быть null");
		
		this.model = model;
	}
}