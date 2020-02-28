package mvc.model.storage;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.storage.local.AssetsStorage;
import mvc.model.storage.local.BrowserStorage;

/**
 * Менеджер хранилищей игровых данных.
 * Содержит все доступные хранилища для игровых данных.
 * @author VolkovRA
 */
class StorageManager extends AModel 
{
	/**
	 * Хранилище данных в ассетах игры.
	 * Из этого хранилища доступно только чтение, используетс для хранения конфигурации уровней.
	 * Не может быть null.
	 */
	public var assets(default, null):IStorage;
	/**
	 * Хранилище игровых данные в браузере.
	 * Используется для хранения прогресса игрока.
	 * Не может быть null.
	 */
	public var browser(default, null):IStorage;
	
	/**
	 * Создать менеджер хранилищей данных.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
		
		assets = new AssetsStorage(model);
		browser = new BrowserStorage(model);
	}
}