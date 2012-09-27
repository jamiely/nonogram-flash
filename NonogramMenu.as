package jal.nonogram {
	import flash.display.MovieClip;
	/**
	 * Designed to choose a menu
	 */ 
	public class NonogramMenu extends MovieClip {
		private var _items: Array = null;
		
		function NonogramMenu () {
		}
		
		public function get items (): Array {
			return this._items;
		}
		
		/**
		 * Adds the menu item to the menu list.
		 */
		public function addItem ( item: NonogramMenuItem ): void {
			this._items.push ( item );
			this.addChild ( item ); 
		}
		
		/**
		 * Arranges added menu items in the menu (maybe alphabetically)
		 */
		public function arrange (): void {
			// sort alphabetically by title
			// arrange by altering x and y
		}
		
	}
}
