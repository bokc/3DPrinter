include <Param.scad>;
use <ConeBearing.scad>;

module angle_percages(L, e) {
    translate([-L*2/3, Frame_e/2,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([-L/3, Frame_e/2,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([Frame_e/2, -L*2/3,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([Frame_e/2, -L/3,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
}

module angle_coulisses(L,e) {
    translate([-coulisse_ec,0.05+Frame_e+e, -coulisse_eh-coulisse_e]) rotate([90,0,0]) cylinder(d=coulisse_d+1, h=L+Frame_e+e+0.1, $fn=_globalResolution);
    translate([-0.05-L,-coulisse_ec, -coulisse_eh]) rotate([0,90,0]) cylinder(d=coulisse_d*1.2, h=L+Frame_e+e+0.1, $fn=_globalResolution);
}

module angle_1(L,l,e,H) {
    retour_h = 15;
    difference(){
        translate([-L,-l,-H]) {
            color("Red") union() {
                difference(){
                    union() {
                        cube([L,l,H]);
                        translate([0,0,H]) cube([L+Frame_e+e,l+Frame_e+e,e]);
                        translate([L+Frame_e,0,H-retour_h]) cube([e,l+Frame_e+e,retour_h]);
                        translate([0,l+Frame_e,H-retour_h]) cube([L+Frame_e+e,e,retour_h]);
                    }
                    translate([-0.1,-0.1,-0.05]) cube([L-e+0.1,l-e+0.1,H+e+0.1]);
                }
                translate([L-e,l-coulisse_ec, H-coulisse_eh]) rotate([0,-90,0]) cone_r608z();
                translate([L-coulisse_ec,l-e, H-coulisse_eh-coulisse_e]) rotate([90,0,0]) cone_r608z();
            }
        }
        angle_coulisses(L,e);
        angle_percages(L,e);
    }
}

module angle_r608z_1(e,H) {
    translate([-e,-coulisse_ec, -coulisse_eh]) rotate([0,-90,0]) bearing608z();
    translate([-e-r608z_e,-coulisse_ec, -coulisse_eh]) rotate([0,-90,0]) import("Pulley_GT2_35tooth_8mm.stl");
    
    translate([-coulisse_ec,-e, -coulisse_eh-coulisse_e]) rotate([90,0,0]) bearing608z();
    translate([-coulisse_ec,-e-r608z_e, -coulisse_eh-coulisse_e]) rotate([90,0,0]) import("Pulley_GT2_35tooth_8mm.stl");
}

module angle_2(L,l,e,H) {
    mirror([1,0,0]) angle_1(L,l,e,H);
}

module angle_r608z_2(e,H) {
    mirror([1,0,0]) angle_r608z_1(e,H);
}

module angle_3(L,l,e,H) {
    mirror([0,1,0]) angle_1(L,l,e,H);
}

module angle_r608z_3(e,H) {
    mirror([0,1,0]) angle_r608z_1(e,H);
}

module angle_4(L,l,e,H) {
    color("Red")
    union() {
        mirror([1,0,0]) mirror([0,1,0]) angle_1(L,l,e,H);
        difference(){
            translate([-Frame_e-e,-Frame_e-2.5*e-nema17_L,-nema17_L-coulisse_e+e]) cube([e,l+2.5*e+Frame_e+nema17_L,nema17_L+coulisse_e]);
            translate([-Frame_e,-nema17_L-Frame_e-.9*e,-coulisse_ec]) nema_fixation(e,2*e,_globalResolution);
            mirror([1,0,0]) mirror([0,1,0]) angle_coulisses(L,e);
        }
    }
}

module angle_r608z_4(e,H) {
    mirror([1,0,0]) mirror([0,1,0]) angle_r608z_1(e,H);
}

//L = coulisse_ec+r608z_D;
//l = coulisse_ec+r608z_D;
//H = coulisse_e+coulisse_eh+r608z_D;
//e = 5;

//angle_1(L,l,e,H);