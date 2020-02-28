package mvc.model.storage.local;

import js.Browser;
import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.data.GameData;
import mvc.model.parser.ParserOptions;
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
	public function load(callback:StorageCallbackLoaded = null, to:GameData = null, options:ParserOptions = null):Void {
		var str:String = null;
		try {
			str = Browser.window.localStorage.getItem(KEY_GAME_DATA);
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err, to);
			
			return;
		}
		
		// Пусто?
		if (str == null || str.length == 0) {
			if (callback != null)
				callback(null, to);
			
			return;
		}
		
		// Ожидаем JSON:
		try {
			to = model.parser.json.read(str, to, options);
			str = null;
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err, to);
			
			return;
		}
		
		// Всё ок:
		if (callback != null)
			callback(null, to);
	}
	public function save(data:GameData, callback:StorageCallbackSaved = null, options:ParserOptions = null):Void {
		var str:String = null;
		try {
			str = model.parser.json.write(data, options);
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