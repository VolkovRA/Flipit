package mvc.controller.game;

import mvc.controller.AController;
import mvc.controller.Controller;
import mvc.model.data.level.LevelData.LevelID;
import openfl.errors.Error;

/**
 * Игровой контроллер.
 * @author VolkovRA
 */
class GameController extends AController 
{
	/**
	 * Создать игровой контроллер.
	 * @param	controller Главный контроллер.
	 */
	public function new(controller:Controller) {
		super(controller);
	}
	
	/**
	 * Запустить игровой уровень.
	 * @param	level ID Игрового уровня.
	 */
	public function runLevel(level:LevelID):Void {
		var game = controller.model.game;
		if (game.data == null)
			throw new Error("Игровые данные не загружены");
		
		var data = game.data.levels.getItemByID(level);
		if (data == null)
			throw new Error("Отсутствуют данные уровня id=" + level);
		
		game.startGame(level);
		controller.view.game.showGame();
	}
}