package mvc.view.game;

import mvc.view.View;
import mvc.view.scene.MenuScene;
import mvc.view.scene.EndScene;
import mvc.view.scene.LevelsScene;
import mvc.view.scene.PlayScene;
import mvc.view.scene.SceneManager;

/**
 * Визуализатор запущенной игры.
 * @author VolkovRA
 */
class GameView extends SceneManager 
{
	/**
	 * Сцена с главным игровым меню.
	 * Не может быть null.
	 */
	public var menuScene(default, null):MenuScene;
	/**
	 * Сцена завершения игры.
	 * Не может быть null.
	 */
	public var endScene(default, null):EndScene;
	/**
	 * Сцена выбора игрового уровня.
	 * Не может быть null.
	 */
	public var levelsScene(default, null):LevelsScene;
	/**
	 * Сцена с основным игровым процессом.
	 * Не может быть null.
	 */
	public var playScene(default, null):PlayScene;
	
	/**
	 * Создать визуализатор запущенной игры.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация.
		// Сцены:
		menuScene		= new MenuScene(view);
		endScene		= new EndScene(view);
		levelsScene		= new LevelsScene(view);
		playScene		= new PlayScene(view);
	}
	
	// СЦЕНЫ
	/**
	 * Перейти на главный экран.
	 */
	public function showMainMenu():Void {
		if (scene == menuScene)
			return;
		
		showScene(menuScene);
	}
	/**
	 * Перейти на выбор уровня.
	 */
	public function showChooseLevel():Void {
		if (scene == levelsScene)
			return;
		
		showScene(levelsScene);
	}
	/**
	 * Перейти на экран игры.
	 */
	public function showGame():Void {
		if (scene == playScene)
			return;
		
		showScene(playScene);
	}
	/**
	 * Перейти на завершающий экран.
	 */
	public function showGameOver():Void {
		if (scene == endScene)
			return;
		
		showScene(endScene);
	}
}