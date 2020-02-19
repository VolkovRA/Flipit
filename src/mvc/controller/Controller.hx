package mvc.controller;

import mvc.model.Model;
import mvc.view.View;
import openfl.errors.Error;

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
		if (model == null)
			throw new Error("Ссылка на главную модель не должна быть null");
		if (view == null)
			throw new Error("Ссылка на главный визуализатор не должна быть null");
		
		this.model = model;
		this.view = view;
		
		// ...
	}
}