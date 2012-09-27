package jal.nonogram {
	import flash.geom.Point;
		
	public class NonogramRow extends NonogramCellContainer {
		private var _rowNumber: uint = 0;
		
		function NonogramRow ( rowNumber: uint ) {
			super ();
			this._rowNumber = rowNumber; // unsigned b/c index
		}
		
		public function get rowNumber (): uint {
			return this._rowNumber;
		}
	}
}