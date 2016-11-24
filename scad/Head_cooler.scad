
L=31;
    l=42;
    h=13;

module pyramid(w, l, h, L) {
	mw = w/2;
	ml = l/2;
	polyhedron(points = [
		[0,  0,  0],
		[w,  l,  0],
		[-w,  l,  0],
		[0, L, h]
	], faces = [
		[3, 1, 0],
		[3, 0, 2],
        [3, 2,1],
		//base
		[0, 1, 2]
	],convexity = 10);
}

module remove() {
    translate ([-12,20,0]) rotate([0,0,60]) cube([20,20,1.2], center =true);
    translate ([12,20,0]) rotate([0,0,-60]) cube([20,20,1.2], center =true);
    translate ([-15.8,14.2,0]) rotate([0,0,20]) cube([8.5,20,1.2], center =true);
    translate ([+15.8,14.2,0]) rotate([0,0,-20]) cube([8.5,20,1.2], center =true);
}


module corps(e=1) {    
    //hull() {
        difference() {
            cube([L,l,e], center=true);
            remove();
        }
        //translate([-L/2,-l/2,h]) cube([L,l/2,e]);
    //}
}
difference() {
    union() {
        pyramid(9,15,15, 23);
        translate([0,8,0])pyramid(15,9,15, 15);
    }
    translate([0,2,1]) union() {
        pyramid(8,14,14, 22);
        translate([0,8,0])pyramid(14,8,14, 14);
    }
}
difference() {
    polyhedron(points = [[0,23,15],[15,17,0],[-15,17,0],[15,23,0],[-15,23,0] ],
            faces= [[0,1,2], [0,1,3], [0,2,4], [0,3,4], [1,3,4,2]]);
    polyhedron(points = [[0,22,14],[13,17,1],[-13,17,1],[0,24,14],[13,23,1],[-13,23,1] ],
            faces= [[0,1,2], [0,1,4, 3], [0,2,5, 3], [0,4,5], [1,4,5,2]]);
}
//corps();


//color ("red") translate([-18.5, -0,-28]) rotate([0, 0, 0]) import("../stl/Chimera_Part_Cooling_Duct.stl");