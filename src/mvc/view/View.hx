package mvc.view;

import mvc.controller.Controller;
import mvc.model.Model;
import openfl.errors.Error;

/**
 * Главный визуализатор.
 * @author VolkovRA
 */
class View extends AView 
{
	/**
	 * Главная, игровая модель.
	 * Не может быть null.
	 */
	public var model(default, null):Model = null;
	
	/**
	 * Главный, игровой контроллер.
	 * Не может быть null.
	 */
	public var controller(default, null):Controller = null;
	
	/**
	 * Создать главный, игровой визуализатор.
	 * @param	model Главная модель.
	 * @param	controller Главный контроллер.
	 */
	public function new(model:Model, controller:Controller) {
		super(this);
		
		if (model == null)
			throw new Error("Ссылка на главную модель не должна быть null");
		if (controller == null)
			throw new Error("Ссылка на главный контроллер не должна быть null");
		
		this.model = model;
		this.controller = controller;
	}
}