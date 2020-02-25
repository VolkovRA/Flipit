package mvc.view;

import mvc.controller.Controller;
import mvc.model.Model;
import mvc.view.game.GameView;
import openfl.display.Sprite;
import openfl.errors.Error;
import motion.Actuate;

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
	public var model(default, null):Model;
	
	/**
	 * Главный, игровой контроллер.
	 * Не может быть null.
	 */
	public var controller(default, null):Controller;
	
	/**
	 * Визуализатор игры.
	 * Не может быть null.
	 */
	public var game(default, null):GameView;
	
	// Приват
	private var fakeSprite:Sprite;
	
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
		
		// Отображение игры:
		game = new GameView(this);
		addChild(game);
	}
	
	/**
	 * Запустить фейковую анимацию для обхода бага Actuate.
	 * В библиотеке анимаций Actuate есть баг - при анимации alpha у текстовых полей (как минимум) не вызывается update твинов, если в данный момент анимируется только один объект. (Типо того, глубоко не копал)
	 * Обойти можно по разному, например, запуская твин с не alpha свойства, при этом, объект обязательно должен быть на stage.
	 * Вызов этого метода гарантирует корректную работу твинов с alpha свойством на указанный промежуток времени: time.
	 * @param	time Продолжительность анимации в sec.
	 */
	public function runFakeAnimation(time:Float):Void {
		if (fakeSprite == null) {
			fakeSprite = new Sprite();
			addChild(fakeSprite);
		}
		
		Actuate.stop(fakeSprite);
		fakeSprite.y = 100000;
		Actuate.tween(fakeSprite, time, { y:100100 });
	}
}