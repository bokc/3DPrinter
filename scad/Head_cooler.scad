include <Param.scad>;

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

module holl() {
    union() {
        rotate([0,0,58]) cube([10,2,1.2], center =true);
        translate([4.6,5.1,0]) rotate([0,0,30]) cube([6,2,1.2], center =true);
    }
}

module headCooler() {
   difference() {
        union() { 
            corps1(h=15, e=1, l=15);
            //corps2(h=15, e=1, l=15);
            translate([0,17,0]) corps3(h=15, e=1, l=15);
        }
        translate([4,11,0.5]) {
            holl();
        }
        translate([-4,11,0.5]) mirror([1,0,0]) holl();
    }
}

module corps1(h,e, l) {
    difference() {
        union() {
            pyramid(9,l,h, 23);
            translate([0,8,0])pyramid(l,9,h, 15);
        }
        translate([0,2,1]) union() {
            pyramid(8,l-e,h-e, 22);
            translate([0,8,0])pyramid(l-e,8,h-e, 13);
        }
    }
}

module corps2(h,e, l) {
    difference() {
        polyhedron(points = [[0,23,h],[l,17,0],[-l,17,0],[l,23,0],[-l,23,0] ],
                faces= [[0,1,2], [0,3,1], [0,4,3],[0,2,4], [1,3,4,2]],convexity = 10);
        polyhedron(points = [[0,22,h-e],[l-2*e,17,e],[-l+2*e,17,e],[0,24,h-e],[l-e*2,23,e],[-l+2*e,23,e] ],
                faces= [[0,1,2], [0,3,4,1], [3,5,4], [0,2,5,3], [1,4,5,2]],convexity = 10);
    }
}

module corps3(h, e, l) {
    L=25;
    difference() {
        polyhedron(points = [[0,6,h],[l,0,0], [-l,0,0], [l,L,0], [l,L,Fan_radial_e_h+2*e], [-l,L,Fan_radial_e_h+2*e], [-l,L,0]],
                faces= [[0,1,2], [0,4,1], [4,3,1], [0,5,4], [4,5,6,3], [0,2,5], [5,2,6], [1,3,6,2]],convexity = 10);
        polyhedron(points = [[0,5,h-e],[l-2*e,-0.1,e], [-l+2*e,-0.1,e], [l-e,L+0.1,e], [l-e,L+0.1,Fan_radial_e_h+e], [-l+e,L+0.1,Fan_radial_e_h+e], [-l+e,L+0.1,e]],
                faces= [[0,1,2], [0,4,1], [4,3,1], [0,5,4], [4,5,6,3], [0,2,5], [5,2,6], [1,3,6,2]],convexity = 10);
    }
}

headCooler();


//color ("red") translate([-18.5, -0,-28]) rotate([0, 0, 0]) import("../stl/Chimera_Part_Cooling_Duct.stl");