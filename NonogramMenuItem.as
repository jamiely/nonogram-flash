package jal.nonogram {
	import flash.display.MovieClip;
	/**
	 * Designed to choose a menu
	 */ 
	public class NonogramMenuItem extends MovieClip {
		
		private var _nonogram: String = "xxooooooooxxooooooooxxxxooooooxxxxooooooxxxxxxooooxxxxxxooooxxxxxxxxooxxxxxxxxooxxxxxxxxxxxxxxxxxxxx";
		private var _title: String = "No title";
		private var _width: uint = 10;
		private var _height: uint = 10;
		
		function NonogramMenuItem (width: uint, height: uint, nonogram: String, title: String) {
			this._title = title;
			this._width = width;
			this._height = height;
			this._nonogram = nonogram;
		}
		
		private function get NonogramString (): String {
			return this._width + ';' + this._height + ';' + this._nonogram + ';' + this._title;
		}
	}
}
