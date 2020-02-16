package mvc.controller;

import openfl.errors.Error;
import mvc.model.Model;
import mvc.view.View;

/**
 * Главный, игровой контроллер.
 * @author VolkovRA
 */
class Controller extends AController 
{
	/**
	 * Главная, игровая модель.
	 * Не может быть null после запуска игры.
	 */
	public var model(default, null):Model = null;
	/**
	 * Главный, игровой визуализатор.
	 * Не может быть null после запуска игры.
	 */
	public var view(default, null):View = null;
	
	/**
	 * Создать главный, игровой контроллер.
	 */
	public function new() {
		super(this);
	}
	
	/**
	 * Запустить игру.
	 * @param	model Главная модель.
	 * @param	view Главный визуализатор.
	 */
	public function run(model:Model, view:View):Void {
		if (model == null)		throw new Error("model - " + ErrorMessages.NULL);
		if (view == null)		throw new Error("view - " + ErrorMessages.NULL);
		
		this.model = model;
		this.view = view;
		
		// ...
	}
}