
// Open SCAD model of linear Bearing LM-8-UU & KB-12-WW

//     LM-8-UU        KB-12-WW
//	D_Int =  8.0	D_Int = 12.0
//	D_Ext = 15.0	D_Ext = 22.0
//	D_1   = 14.3	D_1   = 21.0
//	L     = 24.0	L     = 32.0
//	W     =  1.1	W     =  1.3
//	B     = 17.5	B     = 22.9



module groove(d1, d2, w) {
	difference() {
		cylinder(r=d1/2+1, h=w, center=true);
		cylinder(r=d2/2  , h=w, center=true);
	}
}

module lb(D_Int=8, D_Ext=15, D_1=14.3, L=24, W=1.1, B=17.5) {
chamf = D_Ext - D_1;
	difference() {
		hull() {
			cylinder(r=D_Ext/2, h=L-chamf, center=true);
			cylinder(r=D_1  /2, h=L      , center=true);
		}
		cylinder(r=D_Int/2, h=L+2    , center=true);
		translate([0, 0, B/2-W/2]) groove(D_Ext, D_1, W);
		translate([0, 0,-B/2+W/2]) groove(D_Ext, D_1, W);
		translate([0, 0,     L/2]) groove(D_Ext-(D_Ext-D_Int)/2, 1, W);
		translate([0, 0,    -L/2]) groove(D_Ext-(D_Ext-D_Int)/2, 1, W);
	}
}


module linear_bearing(linear_bearing_type) {
	if(linear_bearing_type == "LM-8-UU") {   //LM-8-UU
		lb(D_Int=8, D_Ext=15, D_1=14.3, L=24, W=1.1, B=17.5);
	}
	else {
		if(linear_bearing_type == "KB-12-WW") {   //KB-12-WW
			lb(D_Int=12, D_Ext=22, D_1=21, L=32, W=1.3, B=22.9);
		}
	}
}


translate([0,  0, 12]) linear_bearing("LM-8-UU" );
translate([0, 20, 16]) linear_bearing("KB-12-WW");