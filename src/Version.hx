package;

/**
 * Описание версии ПО.
 * @author VolkovRA
 */
class Version 
{
	/**
	 * Получить версию из строки.
	 * Парсит строку и возвращает экземпляр описания версии ПО.
	 * @param	str Строка версии. (Пример: "0.0.0" )
	 * @return	Возвращает объект описания версии ПО, не может быть null.
	 */
	static public function fromString(str:String):Version {
		var v:Version = new Version();
		
		if (str == null)
			return v;
		
		var arr:Array<String> = str.split(".");
		var len:Int = arr.length;
		
		if (len > 0)	v.major = readInt(arr[0]);
		if (len > 1)	v.minor = readInt(arr[1]);
		if (len > 2)	v.patch = readInt(arr[2]);
		
		return v;
	}
	static private inline function readInt(value:String):Int {
		if (value == null)
			return 0;
		if (value == "")
			return 0;
		
		return Std.int(Std.parseFloat(value));
	}
	
	/**
	 * MAJOR Версия, когда делаются несовместимые изменения.
	 * По умолчанию: 0.
	 */
	public var major:Int;
	
	/**
	 * MINOR Версия, когда добавляется новая функциональность обратно совместимым образом.
	 * По умолчанию: 0.
	 */
	public var minor:Int;
	
	/**
	 * PATCH Версия, когда дорабатывается уже существующий функционал обратно совместимым образом.
	 * По умолчанию: 0.
	 */
	public var patch:Int;
	
	/**
	 * Создать версию ПО.
	 * @param	major Major версия.
	 * @param	minor Minor версия.
	 * @param	patch Patch версия.
	 */
	public function new(major:Int = 0, minor:Int = 0, patch:Int = 0) {
		this.major = major;
		this.minor = minor;
		this.patch = patch;
	}
	
	/**
	 * Распечатать версию.
	 * Пример вывода: "0.0.0"
	 */
	@:keep
	public function toString():String {
		return major + '.' + minor+ '.' + patch;
	}
}