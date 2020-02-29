package mvc.view.other;

import haxe.ds.Vector;
import motion.Actuate;
import motion.actuators.GenericActuator;
import motion.easing.Back;
import mvc.model.board.Board;
import mvc.model.board.BoardEvent;
import mvc.model.game.GameState;
import mvc.view.AView;
import mvc.view.View;
import openfl.Assets;
import openfl.events.MouseEvent;
import openfl.media.Sound;
import ui.ChipButton;

/**
 * Отображалка игровой доски.
 * @author VolkovRA
 */
class BoardView extends AView 
{
	static private inline var CHIP_START_POS_X:Float		= 72;
	static private inline var CHIP_START_POS_Y:Float		= 350;
	static private inline var CHIP_WIDTH:Float				= 50;
	static private inline var CHIP_HEIGHT:Float				= 50;
	
	/**
	 * Отображаемая доска.
	 * Назначьте доску для отображения.
	 * По умолчанию: null.
	 */
	public var board(default, set):Board = null;
	
	// Приват
	private var chips:Vector<Vector<ChipButton>> = null;
	private var tileSound1:Sound = Assets.getSound("assets/sound/tile_1.mp3");
	private var tileSound2:Sound = Assets.getSound("assets/sound/tile_2.mp3");
	private var tileSound3:Sound = Assets.getSound("assets/sound/tile_3.mp3");
	
	/**
	 * Создать отображалку игровой доски.
	 * @param	view Главная вьюшка.
	 */
	public function new(view:View) {
		super(view);
	}
	
	// ПАБЛИК
	/**
	 * Воспроизвести анимацию заполнения поля.
	 * Если какая-то анимация уже воспроизводится - она прекращается а её предыдущий колбек затирается.
	 * @param	callback Функция обратного вызова после завершения анимации.
	 */
	public function playAnimationIn(callback:Void->Void = null):Void {
		stopAnimation();
		
		if (chips != null && chips.length > 0 && chips[0].length > 0) {
			var width				= chips.length;
			var height				= chips[0].length;
			var x:Int				= 0;
			var delay:Float			= 0;
			var tween:GenericActuator<ChipButton> = null;
			while (x < width) {
				var y				= 0;
				while (y < height) {
					var chip		= chips[x][y];
					chip.x			= CHIP_START_POS_X;
					chip.y			= CHIP_START_POS_Y;
					chip.rotation	= x < width / 2 ? -90 : 90;
					chip.alpha		= 1;
					chip.scaleX		= 1;
					chip.scaleY		= 1;
					
					tween			= Actuate.tween(chip, 0.9, { rotation:0, x:x * CHIP_WIDTH, y:y * CHIP_HEIGHT }).delay(delay);
					
					delay			+= 0.09;
					y ++;
				}
				x ++;
			}
			
			if (callback != null)
				tween.onComplete(callback);
		}
	}
	/**
	 * Воспроизвести анимацию удаления поля.
	 * Если какая-то анимация уже воспроизводится - она прекращается а её предыдущий колбек затирается.
	 * @param	callback Функция обратного вызова после завершения анимации.
	 */
	public function playAnimationOut(callback:Void->Void = null):Void {
		stopAnimation();
		
		if (chips != null && chips.length > 0 && chips[0].length > 0) {
			var width				= chips.length;
			var height				= chips[0].length;
			var x:Int				= 0;
			var delay:Float			= 0;
			var tween:GenericActuator<ChipButton> = null;
			while (x < width) {
				var y				= 0;
				while (y < height) {
					var chip		= chips[x][y];
					chip.mouseChildren	= false;
					chip.mouseEnabled	= false;
					
					tween			= Actuate.tween(chip, 0.5, { alpha:0, scaleX:2, scaleY:2 }).delay(delay).ease(Back.easeIn);
					
					delay			+= 0.05;
					y ++;
				}
				x ++;
			}
			
			if (callback != null)
				tween.onComplete(callback);
		}
	}
	/**
	 * Воспроизвести анимацию победного удаления.
	 * Если какая-то анимация уже воспроизводится - она прекращается а её предыдущий колбек затирается.
	 * @param	callback Функция обратного вызова после завершения анимации.
	 */
	public function playAnimationComplete(callback:Void->Void = null):Void {
		stopAnimation();
		
		if (chips != null && chips.length > 0 && chips[0].length > 0) {
			var width				= chips.length;
			var height				= chips[0].length;
			var x:Int				= 0;
			var delay:Float			= 2;
			var tween:GenericActuator<ChipButton> = null;
			while (x < width) {
				var y				= 0;
				while (y < height) {
					var chip		= chips[x][y];
					chip.mouseChildren	= false;
					chip.mouseEnabled	= false;
					
					tween			= Actuate.tween(chip, 0.5, { x:72, y:-250 }).delay(delay).ease(Back.easeIn);
					
					delay			+= 0.05;
					y ++;
				}
				x ++;
			}
			
			if (callback != null)
				tween.onComplete(callback);
		}
	}
	/**
	 * Принудительное завершение анимации.
	 * Фишки остановятся на своих текущих местах!
	 */
	public function stopAnimation():Void {
		if (chips != null) {
			var x = chips.length;
			while (x-- > 0) {
				var y = chips[x].length;
				while (y-- > 0)
					Actuate.stop(chips[x][y], null, false, false);
			}
		}
	}
	/**
	 * Позицианировать фишки на своих местах.
	 * Эта функция нужна для ручного позицианирования, если, например, анимация была прервана.
	 */
	public function positioningChips():Void {
		if (chips != null) {
			var x = chips.length;
			while (x-- > 0) {
				var y = chips[x].length;
				while (y-- > 0) {
					var chip		= chips[x][y];
					
					Actuate.stop(chip);
					
					chip.x			= CHIP_WIDTH * x;
					chip.y			= CHIP_HEIGHT * y;
					chip.rotation	= 0;
					chip.alpha		= 1;
					chip.scaleX		= 1;
					chip.scaleY		= 1;
					chip.mouseChildren	= true;
					chip.mouseEnabled	= true;
				}
			}
		}
	}
	
	// ЛИСТЕНЕРЫ
	// Доска:
	private function onBoardChange(e:BoardEvent):Void {
		reloadChips();
	}
	private function onBoardChipState(e:BoardEvent):Void {
		chips[e.x][e.y].state = view.model.game.board.getChip(e.x, e.y);
		chips[e.x][e.y].playAnimationIn();
	}
	// Гуи:
	private function onChipPress(e:MouseEvent):Void {
		if (view.model.game.state != GameState.RUNNING)
			return;
		
		var bt:ChipButton = e.currentTarget;
		var r = Math.random();
		if (r < 0.33)
			tileSound1.play();
		else if (r < 0.66)
			tileSound2.play();
		else
			tileSound3.play();
		
		view.model.game.step(bt.indexX, bt.indexY);
	}
	
	// ПРИВАТ
	private function reloadChips():Void {
		stopAnimation();
		removeChildren();
		
		chips = null;
		
		if (board == null)
			return;
		
		chips = new Vector(board.width);
		
		var indexX = 0;
		while (indexX < board.width) {
			chips[indexX] = new Vector(board.height);
			
			var indexY = 0;
			while (indexY < board.height) {
				var chip		= new ChipButton();
				chip.x			= CHIP_WIDTH * indexX;
				chip.y			= CHIP_HEIGHT * indexY;
				chip.indexX		= indexX;
				chip.indexY		= indexY;
				chip.state		= board.getChip(indexX, indexY);
				chip.addEventListener(MouseEvent.MOUSE_DOWN, onChipPress);
				addChild(chip);
				
				chips[indexX][indexY] = chip;
				
				indexY ++;
			}
			
			indexX ++;
		}
	}
	private function removeBoardListeners(board:Board):Void {
		board.removeEventListener(BoardEvent.CHANGE, onBoardChange);
		board.removeEventListener(BoardEvent.CHIP_STATE, onBoardChipState);
	}
	
	// СЕТТЕРЫ
	function set_board(value:Board):Board {
		if (value == board)
			return value;
		
		if (board != null) {
			board.removeEventListener(BoardEvent.CHANGE, onBoardChange);
			board.removeEventListener(BoardEvent.CHIP_STATE, onBoardChipState);
		}
		
		board = value;
		
		if (board != null) {
			board.addEventListener(BoardEvent.CHANGE, onBoardChange);
			board.addEventListener(BoardEvent.CHIP_STATE, onBoardChipState);
		}
		
		reloadChips();
		
		return value;
	}
}