package mvc.model.storage;

import mvc.model.data.GameData;
import mvc.model.parser.ParserOptions;

/**
 * Хранилище данных.
 * Обеспечивает сохранение и загрузку игровых данных из внешней системы.
 * @author VolkovRA
 */
interface IStorage 
{
	/**
	 * Загрузить игровые данные.
	 * Выполняется асинхронная загрузка игровых данных из внешней системы.
	 * Обратите внимание, что вызов колбека может произойти в этот-же момент, если внешняя среда фактически выполняет загрузку синхронно.
	 * @param	callback Функция обратного вызова завершения операции.
	 * @param	to Объект для заполнения данными. Если null - создаётся новый.
	 * @param	options Опций для выбора загружаемых данных.
	 */
	public function load(callback:StorageCallbackLoaded = null, to:GameData = null, options:ParserOptions = null):Void;
	/**
	 * Созранить игровые данные.
	 * Выполняется запись игровых данных во внешнюю систему.
	 * Обратите внимание, что вызов колбека может произойти в этот-же момент, если внешняя среда фактически выполняет сохранение синхронно.
	 * @param	data Записываемые игровые данные.
	 * @param	callback Функция обратного вызова завершения операции.
	 * @param	options Опций для выбора сохраняемых данных.
	 */
	public function save(data:GameData, callback:StorageCallbackSaved = null, options:ParserOptions = null):Void;
}
/**
 * Функция обратного вызова завершения загрузки данных.
 * Если во время загрузки или разбора данных произошла ошибка, она передаётся в качестве первого аргумента функции.
 * Если данные успешно загружены, они передаются вторым аргументом. (Может быть null, если данные загрузить не удалось и они не были переданы в to)
 */
typedef StorageCallbackLoaded = StorageError->GameData->Void;
/**
 * Функция обратного вызова завершения загрузки данных.
 * Если во время загрузки или разбора данных произошла ошибка, она передаётся в качестве первого аргумента функции.
 */
typedef StorageCallbackSaved = StorageError->Void;
/**
 * Ошибка хранилища.
 * Объект описывает ошибку, произошедшую во время выполнения любой операции с хранилищем.
 * Это может быть: <code>js.Error</code>, <code>openfl.errors.Error</code>, или ещё какой нибудь "Error", в зависимости от реализации хранилища.
 */
typedef StorageError = Dynamic;