package mvc.controller;

import mvc.controller.game.GameController;
import mvc.model.Model;
import mvc.model.data.GameData;
import mvc.model.storage.IStorage.StorageError;
import mvc.model.parser.ParserOptions;
import mvc.model.game.GameEvent;
import mvc.view.View;
import openfl.errors.Error;

/**
 * Главный, игровой контроллер.
 * @author VolkovRA
 */
class Controller extends AController 
{
	static private var OPTIONS_GAME:ParserOptions		= { levels:true, boards:true };
	static private var OPTIONS_PLAYER:ParserOptions		= { players:true, progress:true };
	
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
	public function start(model:Model, view:View):Void {
		if (model == null)	throw new Error("Главная модель не должна быть null");
		if (view == null)	throw new Error("Главная вьюшка не должна быть null");
		
		this.model	= model;
		this.view	= view;
		
		// Загружаем игровые данные:
		model.storage.assets.load(onGameDataLoaded, null, OPTIONS_GAME);
	}
	private function onGameDataLoaded(error:StorageError, data:GameData):Void {
		if (error != null)
			throw new Error("Ошибка загрузки данных игры\n" + Std.string(error));
		
		// Подгружаем данные игрока:
		model.storage.browser.load(onPlayerDataLoaded, data, OPTIONS_PLAYER);
	}
	private function onPlayerDataLoaded(error:StorageError, data:GameData):Void {
		if (error != null)
			throw new Error("Ошибка загрузки сохранённых данных игрока\n" + Std.string(error));
		
		// Все данные загружены, запускаем игру:
		controller.model.game.load(data, Settings.PLAYER_ID);
		
		// Сохранение игры при каждом завершении игрового уровня:
		controller.model.game.addEventListener(GameEvent.LEVEL_COMPLETED, onLevelCompleted);
		
		// Переходим в главное меню, передаём управление пользователю:
		view.game.showMainMenu();
	}
	
	/**
	 * Сохранить игру.
	 * Выполняется сохранение прогресса игрока в браузере.
	 */
	public function saveProgress():Void {
		controller.model.storage.browser.save(controller.model.game.data, null, OPTIONS_PLAYER);
	}
	/**
	 * Сбросить рекорд.
	 * Выполняется сброс очков, набранных игроком.
	 */
	public function resetHighest():Void {
		controller.model.game.highest = 0;
		controller.model.storage.browser.save(controller.model.game.data, null, OPTIONS_PLAYER);
	}
	
	// ЛИСТЕНЕРЫ
	private function onLevelCompleted(e:GameEvent):Void {
		saveProgress();
	}
}