package mvc.view.game;

import mvc.view.View;
import mvc.view.scene.MainMenuScene;
import mvc.view.scene.GameOverScene;
import mvc.view.scene.ChooseLevelScene;
import mvc.view.scene.GameScene;
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
	public var mainMenuScene(default, null):MainMenuScene;
	/**
	 * Сцена завершения игры.
	 * Не может быть null.
	 */
	public var gameOverScene(default, null):GameOverScene;
	/**
	 * Сцена выбора игрового уровня.
	 * Не может быть null.
	 */
	public var chooseLevelScene(default, null):ChooseLevelScene;
	/**
	 * Сцена с основным игровым процессом.
	 * Не может быть null.
	 */
	public var gameScene(default, null):GameScene;
	
	/**
	 * Создать визуализатор запущенной игры.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация.
		// Сцены:
		mainMenuScene		= new MainMenuScene(view);
		gameOverScene		= new GameOverScene(view);
		chooseLevelScene	= new ChooseLevelScene(view);
		gameScene			= new GameScene(view);
	}
	
	// СЦЕНЫ
	/**
	 * Перейти на главный экран.
	 */
	public function showMainMenu():Void {
		if (scene == mainMenuScene)
			return;
		
		showScene(mainMenuScene);
	}
	/**
	 * Перейти на выбор уровня.
	 */
	public function showChooseLevel():Void {
		if (scene == chooseLevelScene)
			return;
		
		showScene(chooseLevelScene);
	}
	/**
	 * Перейти на экран игры.
	 */
	public function showGame():Void {
		if (scene == gameScene)
			return;
		
		showScene(gameScene);
	}
	/**
	 * Перейти на завершающий экран.
	 */
	public function showGameOver():Void {
		if (scene == gameOverScene)
			return;
		
		showScene(gameOverScene);
	}
}