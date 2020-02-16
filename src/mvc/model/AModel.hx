package mvc.model;

import openfl.errors.Error;

/**
 * Модель.
 * Абстрактный, базовый класс всех игровых моделей.
 * @author VolkovRA
 */
class AModel 
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
		if (model == null)
			throw new Error("Не передана ссылка на главную игровую модель");
		
		this.model = model;
	}
}