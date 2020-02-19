package mvc.view;

import openfl.display.Sprite;
import openfl.errors.Error;

/**
 * Визуализатор.
 * Абстрактный, базовый класс все игровых визуализаторов.
 * @author VolkovRA
 */
class AView extends Sprite
{
	/**
	 * Главный визуализатор.
	 * Не может быть null.
	 */
	public var view(default, null):View = null;
	
	/**
	 * Создать игровой визуализатор.
	 * @param	view Главный, игровой визуализатор.
	 */
	public function new(view:View) {
		super();
		
		if (view == null)
			throw new Error("Не передана ссылка на главный, игровой визуализатор");
		
		this.view = view;
	}
}