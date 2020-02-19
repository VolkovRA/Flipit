package mvc.model.data;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.data.board.BoardDataList;
import mvc.model.data.level.LevelDataList;
import mvc.model.data.player.PlayerDataList;
import mvc.model.data.progress.ProgressDataList;

/**
 * Игровые данные.
 * @author VolkovRA
 */
class GameData extends AModel 
{
	/**
	 * Данные уровней.
	 * Не может быть null.
	 */
	public var levels(default, null):LevelDataList;
	
	/**
	 * Данные игровых досок.
	 * Не может быть null.
	 */
	public var boards(default, null):BoardDataList;
	
	/**
	 * Данные игроков.
	 * Не может быть null.
	 */
	public var players(default, null):PlayerDataList;
	
	/**
	 * Данные прогресса игроков.
	 * Не может быть null.
	 */
	public var progress(default, null):ProgressDataList;
	
	/**
	 * Создать игровые данные.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
		
		levels			= new LevelDataList(model);
		boards			= new BoardDataList(model);
		players			= new PlayerDataList(model);
		progress		= new ProgressDataList(model);
	}
	
	/**
	 * Выполнить кеширование данных и сохранение перекрёстных ссылок.
	 * Проходит по всем объектам и сохраняет ссылки на связанные данные для быстрого доступа в рантайме.
	 */
	public function cache():Void {
		
	}
	
	/**
	 * Очистить игровые данные.
	 * Приводит объект в исходное состояние, все данные удаляются.
	 */
	public function clear():Void {
		levels.clear();
		boards.clear();
		players.clear();
		progress.clear();
	}
}