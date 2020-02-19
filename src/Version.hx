package;

/**
 * Описание версии ПО.
 * @author VolkovRA
 */
class Version 
{
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