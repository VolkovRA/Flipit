package mvc.model.storage.local;

import js.Browser;
import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.data.GameData;
import mvc.model.storage.IStorage;

/**
 * Браузерное, локальное хранилище.
 * @author VolkovRA
 */
class BrowserStorage extends AModel implements IStorage 
{
	static private inline var KEY_GAME_DATA:String	= "gameData";
	
	public function new(model:Model) {
		super(model);
	}
	public function load(callback:StorageCallbackLoaded = null):Void {
		var str:String = null;
		try {
			str = Browser.window.localStorage.getItem(KEY_GAME_DATA);
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err, null);
			
			return;
		}
		
		// Ожидаем JSON:
		var data:GameData = null;
		try {
			data = model.parser.json.read(str);
			str = null;
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err, null);
			
			return;
		}
		
		// Всё ок:
		if (callback != null)
			callback(null, data);
	}
	public function save(data:GameData, callback:StorageCallbackSaved = null):Void {
		var str:String = null;
		try {
			str = model.parser.json.write(data);
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err);
			
			return;
		}
		
		// Пишем в браузер:
		try {
			Browser.window.localStorage.setItem(KEY_GAME_DATA, str);
			str = null;
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err);
			
			return;
		}
		
		// Всё ок:
		if (callback != null)
			callback(null);
	}
}