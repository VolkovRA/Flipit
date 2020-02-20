package mvc.model.chip;

/**
 * Возможные состояния фишек на игровой доске.
 * @author VolkovRA
 */
@:enum
abstract ChipState(Int) {
	
	/**
	 * Черная фишка.
	 */
	var BLACK = 0;
	
	/**
	 * Белая фишка.
	 */
	var WHITE = 1;
}