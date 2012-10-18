package jal.nonogram {
	import flash.geom.Point;
	
	public dynamic class NonogramCellContainer extends Array {
		public function get groups(): Array {
			var cnt: uint = 0,
				grps: Array = [];
				
			for each ( var cell: NonogramCell in this ) {
				if ( cell.filled ) {
					cnt ++;
				}
				else {
					if ( cnt != 0 ) {
						grps.push ( cnt );
						cnt = 0;
					}
				}
			}
			
			if ( cnt != 0 ) {
				grps.push ( cnt );
				cnt = 0;
			}
	
			if ( grps.length == 0 ) grps = [0];
			
			return grps;
		}
		// public function get groups(): Array {
			// var cnt: uint = 0,
				// grps: Array = [],
				// tmp = [];
				
			// for each ( var cell: NonogramCell in this ) {
				// if ( cell.filled ) {
					// tmp.push ( cell );
				// }
				// else if ( tmp.length != 0 ) {
					// grps.push ( tmp.length );
					// tmp = [];
				// }
			// }
			
			// if ( tmp.length != 0 ) {
				// grps.push ( tmp.length );
			// }
	
			// if ( grps.length == 0 ) grps = [0];
			
			// return grps;
		// }
		// public function get groups(): Array {
			// var cnt: uint = 0,
				// grps: Array = [],
				// tmp = [];
				
			// for each ( var cell: NonogramCell in this ) {
				// if ( cell.filled ) {
					// cnt ++;
				// }
			// }
			
			
			// return [cnt];
		// }
	}
	
}