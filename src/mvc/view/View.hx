package mvc.view;

import openfl.errors.Error;
import mvc.model.Model;
import mvc.controller.Controller;

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
		
		if (model == null)		throw new Error("model - " + ErrorMessages.NULL);
		if (view == null)		throw new Error("view - " + ErrorMessages.NULL);
		
		this.model = model;
		this.controller = controller;
	}
}