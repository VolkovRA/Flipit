package mvc.model.data.progress;

import mvc.model.Model;
import mvc.model.data.DataList;

/**
 * Список данных игрового прогресса.
 * @author VolkovRA
 */
class ProgressDataList extends DataList<ProgressData> 
{
	/**
	 * @inheritDoc
	 */
	public function new(model:Model) {
		super(model);
	}
}