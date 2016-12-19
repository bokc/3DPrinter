include <Param.scad>;
use <fan.scad>;

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
        rotate([0,0,58]) cube([10,2,1.4], center =true);
        translate([4.6,5.1,0]) rotate([0,0,30]) cube([6,2,1.4], center =true);
    }
}

module headCooler() {
   difference() {
        union() { 
            corps1(h=15, e=1, l=15);
            translate([0,17,0]) corps3(h=15, e=1, l=15, L=25, end_h=5, end_l=13.5, end_a=45);
            translate([0,17+25,0]) corps4(h=15, e=1, l=13.5, start_h=5, start_a=45, end_h=5, end_a=40);
            translate([0,34,23]) rotate([46,0,0]) difference() {
                l=8;L=12;h=7.2; 
                attache(l,L,h);
                translate([0,0,0.7])attache(l+0.1,L,Vis_m3_p);
                cube([4.2, L+h*2,h+0.1], center=true);
            }
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

module corps3(h, e, l, L, end_h, end_l, end_a) {
    difference() {
        polyhedron(points = [[0,6,h],[l,0,0], [-l,0,0], [end_l,L,end_h], [end_l,L-sin(end_a)*h, cos(end_a)*h+end_h], [-end_l,L-sin(end_a)*h, cos(end_a)*h+end_h], [-end_l,L,end_h]],
                faces= [[0,1,2], [0,4,1], [4,3,1], [0,5,4], [4,5,6,3], [0,2,5], [5,2,6], [1,3,6,2]],convexity = 10);
        polyhedron(points = [[0,5,h-e*2],[l-2*e,+0.2,e-0.1], [-l+2*e,+0.2,e-0.1], [end_l-e,L+0.1,e+end_h], [end_l-e,L-sin(end_a)*h+0.5,cos(end_a)*h+end_h], [-end_l+e,L-sin(end_a)*h+0.5,cos(end_a)*h+end_h], [-end_l+e,L+0.1,e+end_h]],
                faces= [[0,1,2], [0,4,1], [4,3,1], [0,5,4], [4,5,6,3], [0,2,5], [5,2,6], [1,3,6,2]],convexity = 10);
    }
}

module corps4(h, e, l, start_h, start_a, end_h, end_a) {
    translate([0,0,start_h])
    union() {
        translate([0,14,cos(end_a)*15+end_h]) rotate([-end_a,0,0]) difference() {
            cube([30,30,e], center=true);
            cylinder(d=26, h=e+0.1, center=true, ,$fn=_globalResolution);
            for(i=[0:3]) {
                translate([cos(45+90*i)*17, sin(45+90*i)*17]) cylinder(d=Vis_m3_p, h=e+0.1, center=true,$fn=_globalResolution);
            }
        }
        difference() {
            hull() {
                translate([0,14,cos(end_a)*15+end_h]) rotate([-end_a,0,0]) cylinder(d=26+2*e, h=e, center=true, ,$fn=_globalResolution);
                rotate([start_a,0,0]) translate([0,0,h/2]) cube([l*2,0.1,h], center=true);
            }
            hull() {
                translate([0,14,cos(end_a)*15+end_h]) rotate([-end_a,0,0]) cylinder(d=26, h=e+0.1, center=true, ,$fn=_globalResolution);
                rotate([start_a,0,0]) translate([0,-0.1,h/2]) cube([l*2-e*2,0.1,h-0.1-2*e], center=true);
            }
        }
    } 
}

module attache(l, L, h) {
    union() {
        cube([l, L,h], center=true);
        translate([0,-L/2,0]) rotate([0,90,0]) cylinder(d=h, h=l, center=true, $fn=_globalResolution);
        translate([0,L/2,0]) rotate([0,90,0]) cylinder(d=h, h=l, center=true, $fn=_globalResolution);
    }
}

headCooler();
//rotate([0,0,-90]) translate([-60,0,15]) rotate([0,-45,0]) fan(30, 10, 24, 3.2, 3,-45);
//attache(10,10,5);