include <Param.scad>;
use <ConeBearing.scad>;
use <Nema17Fix.scad>;
use <Bearing.scad>;

module angle_percages(L, e, H) {
    //haut
    translate([-L*2/3, Frame_e/2,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([-L/3, Frame_e/2,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([Frame_e/2, -L*2/3,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([Frame_e/2, -L/3,-0.1]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    
    //Y
    translate([-15,0.1,-e-Frame_e/2]) rotate([90,0,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([-L+10,0.1,-e-Frame_e/2]) rotate([90,0,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([-15,0.1,-H+Frame_e/2]) rotate([90,0,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([-L+10,0.1,-H+Frame_e/2]) rotate([90,0,0]) cylinder(d=4.2, h=e*2+0.2, $fn=_globalResolution);
    translate([-L+10,-e,-H+Frame_e/2]) rotate([90,0,0]) cylinder(d=6, h=e, $fn=_globalResolution); //Tete de vis
    
    //x
    translate([-e-0.1,-15,-e-Frame_e/2]) rotate([0,90,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([-e*2-0.1,-L+10,-e-Frame_e/2]) rotate([0,90,0]) cylinder(d=4.2, h=e*2+0.2, $fn=_globalResolution);
    translate([-e*2-0.1,-L+10,-e-Frame_e/2]) rotate([0,90,0]) cylinder(d=6, h=e, $fn=_globalResolution); //Tete de vis
    translate([-e-0.1,-15,-H+Frame_e/2]) rotate([0,90,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
    translate([-e-0.1, -L+10,-H+Frame_e/2]) rotate([0,90,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
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
        angle_percages(L,e,H);
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
    support_h = nema17_L + coulisse_e;
    difference(){
        union() {
            mirror([1,0,0]) mirror([0,1,0]) angle_1(L,l,e,H);
            difference(){
                color("Red") translate([-Frame_e-e,-Frame_e-2.5*e-nema17_L,-nema17_L-coulisse_e+e]) cube([e,l+2.5*e+Frame_e+nema17_L,support_h]);
                translate([-Frame_e,-nema17_L-Frame_e-.9*e,-coulisse_ec]) nema_fixation(e,2*e,_globalResolution);
                mirror([1,0,0]) mirror([0,1,0]) angle_coulisses(L,e);
            }
        }
        //vis
        translate([-e-0.1-Frame_e,-Frame_e/2,-e-Frame_e/2]) rotate([0,90,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
        translate([-e-0.1-Frame_e,+L-10,-e-Frame_e/2]) rotate([0,90,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
        translate([-e-0.1-Frame_e,-Frame_e/2,-support_h+Frame_e]) rotate([0,90,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
        translate([-e-0.1-Frame_e, +L-10,-support_h+Frame_e]) rotate([0,90,0]) cylinder(d=4.2, h=e+0.2, $fn=_globalResolution);
}
}

module angle_r608z_4(e,H) {
    mirror([1,0,0]) mirror([0,1,0]) angle_r608z_1(e,H);
}

L = coulisse_ec+r608z_D;
l = coulisse_ec+r608z_D;
H = coulisse_e+coulisse_eh+r608z_D;
e = 5;
espace = 60;

translate([espace,espace,0]) angle_1(L,l,e,H);
//color("blue") translate([espace,espace,0]) angle_percages(l,e,H);
translate([-espace,espace,0]) angle_2(L,l,e,H);
translate([espace,-espace,0]) angle_3(L,l,e,H);
translate([-espace,-espace,0]) angle_4(L,l,e,H);