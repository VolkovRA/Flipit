package mvc.view.scene;

import mvc.view.AView;
import mvc.view.View;

/**
 * Менеджер игровых сцен.
 * Позволяет управлять и переключаться между сценами в игре.
 * @author VolkovRA
 */
class SceneManager extends AView 
{
	/**
	 * Текущая, отображаемая сцена.
	 * По умолчанию: null.
	 */
	public var scene(default, null):Scene = null;
	
	/**
	 * Создать менеджер игровых сцен.
	 * @param	view Главная вьюшка.
	 */
	public function new(view:View) {
		super(view);
	}
	
	/**
	 * Показать игровую сцену.
	 * Переключает текущую сцену на указанную. (Предыдущая сцена удаляется из дисплей листа)
	 * Если указанная сцена уже отображается - ничего не происходит.
	 * @param	scene Отображаемая сцена, если null - текущая сцена просто скрывается.
	 */
	public function showScene(scene:Scene = null):Void {
		if (this.scene == scene)
			return;
		
		// Удаление предыдущей сцены:
		if (this.scene != null) {
			if (this.scene.parent == this)
				this.removeChild(this.scene);
			
			this.scene = null;
		}
		
		// Добавление новой сцены:
		if (scene != null) {
			this.scene = scene;
			this.addChild(scene);
		}
	}
}