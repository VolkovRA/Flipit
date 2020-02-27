package mvc.controller;

import mvc.controller.game.GameController;
import mvc.model.Model;
import mvc.view.View;
import openfl.Assets;
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
	 * Игровой контроллер.
	 * Не может быть null.
	 */
	public var game(default, null):GameController;
	
	/**
	 * Создать главный, игровой контроллер.
	 */
	public function new() {
		super(this);
		
		game = new GameController(this);
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
		
		// Загружаем данные игры:
		var data = controller.model.parser.json.read(Assets.getText("assets/config/levels.json"));
		controller.model.game.load(data, Settings.PLAYER_ID);
		
		// Показываем главное меню и передаём в него управление:
		view.game.showMainMenu();
	}
}