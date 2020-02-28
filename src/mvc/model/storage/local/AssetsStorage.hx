package mvc.model.storage.local;

import mvc.model.AModel;
import mvc.model.Model;
import mvc.model.data.GameData;
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
	public function load(callback:StorageCallbackLoaded = null):Void {
		var data:GameData = null;
		try {
			data = model.parser.json.read(Assets.getText("assets/config/levels.json"));
		}
		catch (err:Dynamic) {
			if (callback != null)
				callback(err, data);
			
			return;
		}
		
		callback(null, data);
	}
	public function save(data:GameData, callback:StorageCallbackSaved = null):Void {
		if (callback != null)
			callback(new Error("Нельзя записать данные в ассеты игры"));
	}
}