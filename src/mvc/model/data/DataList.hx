package mvc.model.data;

import mvc.model.AModel;
import mvc.model.Model;
import openfl.errors.Error;

/**
 * Список данных.
 * Абстрактный, базовый класс для всех списков.
 * Инкапсулирует в себе основные методы работы с списками и доступ к данным за: O(1).
 * @author VolkovRA
 */
class DataList<T:DataListItem> extends AModel 
{
	/**
	 * Количество элементов в списке.
	 * По умолчанию: 0.
	 */
	public var length(default, null):Int = 0;
	/**
	 * Максимальный ID в списке.
	 * Это значение проставляется автоматически, когда в список добавляется новая запись с самым большим ID.
	 * Может использоваться как авто-индекс, для добавления записей с уникальным ID.
	 * Не изменяется при удалении из списка записи с самым большим ID.
	 * Сбрасывается при вызове метода: <code>clear()</code>.
	 * По умолчанию: 0.
	 */
	public var maxID:ID = 0;
	/**
	 * Список с ключом по ID.
	 * Не может быть null.
	 */
	private var map:Map<ID, T> = new Map();
	
	/**
	 * Создать список данных.
	 * @param	model Главная модель.
	 */
	public function new(model:Model) {
		super(model);
	}
	
	/**
	 * Получить элемент списка по его ID.
	 * Возвращает элемент с указанным ID или null, если такого нет в списке.
	 * @param	id ID Искомого элемента.
	 */
	public function getItemByID(id:ID):T {
		return map[id];
	}
	
	/**
	 * Добавить новый элемент в список.
	 * Если в списке уже содержится элемент с таким ID, генерируется исключение. (Проверка на уникальность ID)
	 * @param	item Добавляемый элемент.
	 */
	public function add(item:T):Void {
		if (item == null)
			return;
		
		if (map.exists(item.id))
			throw new Error("Список уже содержит элемент с id=" + item.id);
		
		map[item.id] = item;
		length ++;
		
		if (item.id > maxID)
			maxID = item.id;
	}
	
	/**
	 * Удалить элемент из списка.
	 * Удаляет указанный элемент и возвращает true, если тот содержался в списке, иначе false.
	 * @param	item Удаляемый элемент.
	 */
	public function remove(item:T):Bool {
		if (item == null)
			return false;
		
		if (map.remove(item.id)) {
			length --;
			return true;
		}
		
		return false;
	}
	
	/**
	 * Удалить элемент из списка по его ID.
	 * Возвращает удалённый элемент или null, если такого не содержится в списке.
	 * @param	id ID Удаляемого элемента.
	 */
	public function removeByID(id:ID):T {
		var item = map[id];
		if (item == null)
			return null;
		
		map.remove(item.id);
		length --;
		
		return item;
	}
	
	/**
	 * Проверить наличие элемента.
	 * Возвращает true, если указанный элемент содержится в списке.
	 * @param	item Проверяемый элемент.
	 */
	public function has(item:T):Bool {
		if (item == null)
			return false;
		
		return map.exists(item.id);
	}
	
	/**
	 * Проверка наличия элемента с указанным ID.
	 * Возвращает true, если в списке содержится элемент с указанным ID.
	 * @param	id ID Элемента.
	 */
	public function hasID(id:ID):Bool {
		return map.exists(id);
	}
	
	/**
	 * Очистить список.
	 * Удаление всех элементов из списка.
	 */
	public function clear():Void {
		map = new Map();
		length = 0;
		maxID = 0;
	}
	
	// Реализация перечисления:
	public inline function keys():Iterator<ID> {
		return map.keys();
	}
	public inline function iterator():Iterator<T> {
		return map.iterator();
	}
}