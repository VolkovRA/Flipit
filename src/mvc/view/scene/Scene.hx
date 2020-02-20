package mvc.view.scene;

import mvc.view.AView;
import mvc.view.View;

/**
 * Сцена.
 * Базовый класс всех игровых сцен.
 * @author VolkovRA
 */
class Scene extends AView 
{
	/**
	 * Создать сцену.
	 * @param	view Главная вьюшка.
	 */
	public function new(view:View) {
		super(view);
	}
}