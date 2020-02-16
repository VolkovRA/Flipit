package mvc.controller;

import openfl.errors.Error;

/**
 * Контроллер.
 * Абстрактный, базовый класс все игровых контроллеров.
 * @author VolkovRA
 */
class AController 
{
	/**
	 * Главный контроллер.
	 * Не может быть null.
	 */
	public var controller(default, null):Controller = null;
	
	/**
	 * Создать игровой контроллер.
	 * @param	controller Главный контроллер.
	 */
	public function new(controller:Controller) {
		if (controller == null)
			throw new Error("Не передана ссылка на главный, игровой контроллер");
		
		this.controller = controller;
	}
}