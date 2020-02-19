package mvc.model.data.player;

import mvc.model.Model;
import mvc.model.data.DataList;

/**
 * Список данных игроков.
 * @author VolkovRA
 */
class PlayerDataList extends DataList<PlayerData> 
{
	/**
	 * @inheritDoc
	 */
	public function new(model:Model) {
		super(model);
	}
}