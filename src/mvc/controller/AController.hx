package mvc.controller;

import openfl.errors.Error;
import openfl.events.EventDispatcher;

/**
 * Контроллер.
 * Абстрактный, базовый класс все игровых контроллеров.
 * @author VolkovRA
 */
class AController extends EventDispatcher
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
		super();
		
		if (controller == null)
			throw new Error("Главный контроллер не должен быть null");
		
		this.controller = controller;
	}
}