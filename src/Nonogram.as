package jal.nonogram {
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.events.*;
	;
	
	public class Nonogram extends MovieClip {
		/**
		 * Format of string xxooxoxxox
		 * where x is filled
		 * and o is not (oh not zero)
		 */
		private var _nonogram: String;
		private var _width: int = 10;
		private var _height: int = 10;
		
		private var _cells: NonogramCellContainer;
		private var _rows: Array;
		private var _columns: Array;
		
		public static var SIZE:uint = 20;
		
		public var _grid: MovieClip;
		public var _gridHints: MovieClip;
		public var _menu: MovieClip;
		
		
		/**
		 * Constructor
		 */
		function Nonogram ( nonogram: String, w: uint, h: uint ) {
			if ( nonogram == "" ) {
				// default
				// xxooooooooxxooooooooxxxxooooooxxxxooooooxxxxxxooooxxxxxxooooxxxxxxxxooxxxxxxxxooxxxxxxxxxxxxxxxxxxxx
				//nonogram  = "ooooooooooooooooxoooooooooxxooxxxxxxxxxoxxxxxxxxxxxxxxxxxxxoxxxxxxxxooooooooxooooooooooooooooooooooo"; 
				//"ooooooooooxooooooooxoxooooooxoooxooooxoooooxooxoooooooxxoooooooxooxoooooxooooxoooxooooooxoxoooooooox";
				nonogram = "xoooxxoooxoxoooxooxoooxoxooxoooooxoxxoooxoxoxxxoxxxxoxxxoxoxoooxxoxoooooxooxoxoooxooxoooxoxoooxxooox";
				w = 10;
				h = 10;
			}
			
			this._nonogram = nonogram;
			this._width = w;
			this._height = h;
			
			this._load ( nonogram );
			
			if ( nonogram.length != w * h ) {
				// @todo Throw Exception
			}
			
			this.setupMenu ();
			this.addEventListener ( Event.ENTER_FRAME, this.checkWin );
		}
		
		public function reveal (): void {
			for ( var w = 0; w < this._width; w ++ ) {
				for ( var h = 0; h < this._height; h ++ ) {
					this.getCell ( w, h ).reveal ();
				}
			}
		}
		
		private function setupMenu (): void {
			this._menu = new NonogramMenu ();
			this.addChild ( this._menu ); 
			// @todo position menu
			
			this.showMenu ( true );
		}
		
		private function setNonogram ( nonogramString: String ): void {
			// @todo sets the current nonogram string
		}
		
		private function endGame (): void {
			// @todo do end game tasks including setting the high scores lists
			this.showMenu ( true );
		}
		
		//private function startGame (): void () {
			// @todo do start game tasks including reseting all scores and such
			//this.showMenu ( false );
		//}
		
		private function showMenu ( show: Boolean ) {
			this._menu.visible = show;
		}
		
		public static function loadString ( nonogramString: String ): Nonogram {
			var parts = nonogramString.split ( ';' ),
				w = int ( parts[0] ),
				h = int ( parts[1] ),
				game = parts[2];
			return new Nonogram ( game, w, h );
		}
		
		private function _load ( nonogram: String ) {
			
			// setup containers
			this._cells = new NonogramCellContainer();
			this._rows = [];
			this._columns = [];
			
			var char: String,
				x: uint,
				y: uint,
				cell: NonogramCell,
				i: uint;
				
			// force lower case
			nonogram = nonogram.toLowerCase ();
			
			// setup cells, rows, and columns 
			for ( i = 0 ; i < this._height; i ++ ) this._rows.push ( new NonogramRow ( i ) )
			for ( i = 0 ; i < this._width; i ++ ) this._columns.push ( new NonogramColumn ( i ) )
			
			this._grid = new MovieClip ();
			this.addChild ( this._grid );
			this._grid.x = 100;
			this._grid.y = 100;
			
			
			
			
			// the character in question
			for ( i = 0; i < nonogram.length; i ++ ) {
				y = int ( i / this._width );
				x = i - y * this._width; //int ( i % this._width );
				
				char = nonogram.substr ( i, 1 );
				cell = new NonogramCell ( x, y, char == "x" );
				
				trace ( "(" + x + ", " + y + ") " + char );
				
				//this.addChild ( cell ); //adds to movie clip
				this._grid.addChild ( cell );
				this._cells.push ( cell );
				
				cell.x = x * Nonogram.SIZE;
				cell.y = y * Nonogram.SIZE;
				
				this._rows [y].push ( cell );
				this._columns [x].push ( cell );
			}
			
			// create hints
			
			this._gridHints = new MovieClip ();
			this.addChild ( this._gridHints );
			
			var txt:TextField = new TextField (),
				paddingInc: uint = 10,
				padding: uint = 0,
				grp: String;
				
			
			for each (var col in this._columns ) {
				
				txt = new TextField ();
				txt.text = col.groups.join ('\n');
				txt.x = this._grid.x + Nonogram.SIZE * col.columnNumber;
				txt.y = 0;
				txt.width = Nonogram.SIZE;
				txt.autoSize = TextFieldAutoSize.CENTER;
				txt.y = this._grid.y - txt.height;
				//trace ( txt.y );
				this._gridHints.addChild ( txt );
			}
			
			for each (var row in this._rows ) {
				padding = 0;
				txt = new TextField ();
				txt.text = row.groups.join ( ' ' );
				txt.x = 0;
				txt.y = this._grid.y + Nonogram.SIZE * row.rowNumber;
				txt.autoSize = TextFieldAutoSize.RIGHT;
				this._gridHints.addChild ( txt );
			}			
		}
		
		private var _defaultFormat: TextFormat = null;
		
		private function get defaultTextFormat (): TextFormat {
			if ( this._defaultFormat == null ) {
				var format = new TextFormat ();
				format.font = "Verdana";
	            format.color = 0xFF0000;
	            format.size = 8;
				format.bold = true;
	            this._defaultFormat = format;
			}
			return this._defaultFormat;
		}
		
		private function getHintText ( hint: String ): TextField {
			var txt: TextField = new TextField ();
			txt.text = hint; // write number
			txt.autoSize = TextFieldAutoSize.RIGHT;
			txt.defaultTextFormat = this.defaultTextFormat;
			return txt;
		}
		
		/**
		 * 0-based indices
		 */
		public function getCell (x: uint, y: uint) {
			// test boundaries
			if ( this._width < x || this._height < y ) {
				// @todo throw exception
			}
			return this._cells [y * this._width + x ];
		}
		
		public function get cells() : NonogramCellContainer {
			return this._cells;
		}
		
		public function get correct(): Boolean {
			for each ( var c in this._cells ) {
				if ( ! c.correct ) {
					//trace ( c.cellX + ' ' + c.cellY + ' sel? ' + c.selected + ' fill? ' + c.filled );
					return false;
				}
			}
			return true;
		}
		
		private function checkWin ( e:Event ) {
			//trace ( this.correct );
			if ( this.correct ) {
				//trace ( 'correct!' );
				var t = new TextField ();
				t.text = "Congratulations! You're Done!";
				t.width = 200;
				this.addChild ( t );
				t.x = this._grid.x;
				t.y = this._grid.y+this._grid.height;
				
				//this.removeChild ( this._grid );
				//this._gridHints.visible = false;
			}
		}
		
		
		// 18;17;ooxoxooooooooxooxoooxoxoooooooxoooooooxoxooooooxoooooxxxxoxxxoooxooooooooooooooooxooooooooooooooooxooooooooooooooooxoooooxooooooooooxxooooxooooooooooxxooooxooooooooooxxooooxooooooooooxxooooxooooooooooxxooooxoooooooooooxooooxoooooooooooxooooxooooooooooooxoooxoooooooooooooxxxxoooooooooooooxxoooooooooooooooo
		public function currentGridToNonogramString (): String {
			var s = "";
			
			
			for ( var h = 0; h < this._height; h ++ ) {
				for ( var w = 0; w < this._width; w ++ ) {	
					//s += this.getCell ( h, w ).selected == NonogramCell.SelectionType.Filled  ? "x" : "o";
					s += this.getCell ( w, h ).selected == NonogramCell.SelectionType.Filled  ? "x" : "o";
				}
			}
			
			return w + ";" + h + ";" + s;
		}
		
		public function traceNonogramString (): void {
			var s = "";
			for ( var h = 0; h < this._height; h ++ ) {
				s = "";
				for ( var w = 0; w < this._width; w ++ ) {
					s += this.getCell ( w, h ).selected == NonogramCell.SelectionType.Filled  ? "x" : "o";
				}
				trace ( s );
			}
			//return w + ";" + h + ";" + s;
		}
		
		
		// private function assignScrollBar():void {
            // this._sb = new UIScrollBar();
            // //this._sb.move(tf.x + tf.width, tf.y);
            // this._sb.setSize(this.width, this.height);
            // this._sb.scrollTarget = this;
            // this.addChild(_sb);            
        // }		
	}
	
}
