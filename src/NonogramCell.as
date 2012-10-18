package jal.nonogram {
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	
	public class NonogramCell extends MovieClip {
		private var _cellx: uint;
		private var _celly: uint;
		private var _shape: Shape;
		
		/**
		 * True if cell should truly be filled in the end
		 */
		private var _filled: Boolean = false;
		
		/**
		 * Select status
		 */
		private var _selected: uint = 0;
		
		public static var SelectionType: Object = {
			None: 0,
			Unknown: 1,
			Filled: 2,
			Unfilled: 3
		};
		
		function NonogramCell ( x: int, y: int, filled: Boolean ) {
			//super ( x, y );
			this._cellx = x;
			this._celly = y;
			this._filled = filled; // true if cell is filled
			this._selected = NonogramCell.SelectionType.None;
			
			// create
			this._shape = new Shape();
			this.addChild(this._shape);
			
			this.doDrawRect ( Nonogram.SIZE, 0xFFFFFF);
			//this.draw ();
			this.addEventListener ( MouseEvent.CLICK, this.onClick );
			this.addEventListener ( MouseEvent.MOUSE_OVER, this.onMouseOver );
		}
		public function get filled(): Boolean {
			return this._filled;
		}
		public function get cellX (): uint {
			return this._cellx;
		}
		public function get cellY (): uint {
			return this._celly;
		}
		
		
		public function onClick (evt:MouseEvent): void {
			this.applyMouseEvent ( evt );
		}
		
		public function onMouseOver ( evt: MouseEvent ): void {
			if ( ! evt.buttonDown ) return; // do nothing if the mouse button is up
			
			this.applyMouseEvent ( evt );
		}
		
		public function applyMouseEvent (evt:MouseEvent): void {
			
			
			
			// update status
			switch ( this._selected ) {
				case NonogramCell.SelectionType.None: 
					this._selected = evt.shiftKey ? 
						NonogramCell.SelectionType.Unfilled :
						NonogramCell.SelectionType.Filled;
					break;
				case NonogramCell.SelectionType.Unknown:
					// @todo
				case NonogramCell.SelectionType.Unfilled:
					this._selected = evt.shiftKey ? 
						NonogramCell.SelectionType.None :
						NonogramCell.SelectionType.Filled;
					break;
				
				case NonogramCell.SelectionType.Filled:
					this._selected = evt.shiftKey ? 
						NonogramCell.SelectionType.Unfilled :
						NonogramCell.SelectionType.None;
					break;
				
				break;
			}
			
			// update display
			switch ( this._selected ) {
				case NonogramCell.SelectionType.None: 
					this.draw ( false, false );
					break;
				case NonogramCell.SelectionType.Unknown:
					// @todo
				case NonogramCell.SelectionType.Unfilled:
					this.draw ( false, true );
					break;
					
				case NonogramCell.SelectionType.Filled:
					//this.draw ( true, false );
					this.selectFilled ();
				break;
				
			}
		}
		
		public function selectFilled () {
			this._selected = NonogramCell.SelectionType.Filled;
			this.draw ( true, false );
		}
		
		public function reveal () {
			if ( this.filled ) this.selectFilled ();
		}
		
		private function draw ( filled, drawX ) {
			this._shape.graphics.clear ();
			var color: uint = filled ? 0xFFCC00 : 0xFFFFFF;
			
			this.doDrawRect ( Nonogram.SIZE, color);
			
			if ( drawX ) {
				this.doDrawX ( Nonogram.SIZE );
			}
			
		}

        private function doDrawRect(size, bgColor:uint):void {
            var child = this._shape;
			var borderColor:uint  = 0xEEEEEE;
			var borderSize:uint   = 0;

            child.graphics.beginFill(bgColor);
            child.graphics.lineStyle(borderSize, borderColor);
            child.graphics.drawRect(0, 0, size, size);
            child.graphics.endFill();
        }
		
		private function doDrawX(size:uint): void {
			var child = this._shape;
			var borderColor:uint  = 0xEEEEEE;
			var borderSize:uint   = 0;

            //child.graphics.beginFill(bgColor);
            child.graphics.lineStyle(borderSize, borderColor);
			child.graphics.moveTo (0, 0);
			child.graphics.lineTo (size, size);
			child.graphics.moveTo (size, 0);
			child.graphics.lineTo (0, size);
            //child.graphics.drawRect(0, 0, size, size);
            //child.graphics.endFill();
		}
		
		public function get selected (): uint {
			return this._selected;
		}

		public function get correct (): Boolean {
			return ( this.filled && this._selected == NonogramCell.SelectionType.Filled ) || 
				( ! this.filled && this._selected != NonogramCell.SelectionType.Filled );
		}
	}
}