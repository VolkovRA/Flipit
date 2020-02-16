package;

import openfl.display.Sprite;
import mvc.model.Model;
import mvc.view.View;
import mvc.controller.Controller;

/**
 * Приложение.
 * @author VolkovRA
 */
class Main extends Sprite 
{
	/**
	 * Главная, игровая модель.
	 * Не может быть null.
	 */
	static public var model(default, null):Model = null;
	
	/**
	 * Главный, игровой визуализатор.
	 * Не может быть null.
	 */
	static public var view(default, null):View = null;
	
	/**
	 * Главный, игровой контроллер.
	 * Не может быть null.
	 */
	static public var controller(default, null):Controller = null;
	
	/**
	 * Точка входа.
	 */
	public function new() {
		super();
		
		model = new Model();
		controller = new Controller();
		view = new View(model, controller);
		
		this.addChild(view);
		
		// Запуск:
		controller.run(model, view);
		
		trace("Version: " + Settings.VERSION);
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
	}
}