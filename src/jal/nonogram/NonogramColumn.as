package jal.nonogram {
	import flash.geom.Point;
	dynamic public class NonogramColumn extends NonogramCellContainer {
		private var _colNumber: uint = 0;
		function NonogramColumn ( colNumber: uint ) {
			super ();
			this._colNumber = colNumber; // unsigned b/c index
		}
		public function get columnNumber (): uint {
			return this._colNumber;
		}
	}
}