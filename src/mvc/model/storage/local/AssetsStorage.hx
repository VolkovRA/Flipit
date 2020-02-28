package mvc.model.storage.local;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.data.GameData;
import mvc.model.parser.ParserOptions;
import mvc.model.storage.IStorage;
import openfl.Assets;
import openfl.errors.Error;

/**
 * Хранилище игровых данных в ассетах игры.
 * @author VolkovRA
 */
class AssetsStorage extends AModel implements IStorage 
{
	public function new(model:Model) {
		super(model);
	}
	public function load(callback:StorageCallbackLoaded = null, to:GameData = null, options:ParserOptions = null):Void {
		try {
			to = model.parser.json.read(Assets.getText("assets/config/levels.json"), to, options);
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err, to);
			
			return;
		}
		
		callback(null, to);
	}
	public function save(data:GameData, callback:StorageCallbackSaved = null, options:ParserOptions = null):Void {
		if (callback != null)
			callback(new Error("Нельзя записать данные в ассеты игры"));
	}
}