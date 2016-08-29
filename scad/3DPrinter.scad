include <Param.scad>;

use <Nema_17.scad>;
use <Nema17Fix.scad>;
use <AxeZ.scad>;
use <Bearing.scad>;
use <Angle.scad>;
use <slicer.scad>;
use <tools/timing_belts.scad>;

module frame() {
    front_h=angle_h+7;
    color("BurlyWood") {
        translate ([-Frame_L/2+Frame_e, -Frame_l/2+Frame_e,0]) cube([Frame_L-Frame_e, Frame_l-2*Frame_e, Frame_e]);
        translate ([-Frame_L/2, -Frame_l/2,0]) cube([Frame_L, Frame_e, Frame_h]);
        translate ([-Frame_L/2, -Frame_l/2+Frame_e,0]) cube([Frame_e, Frame_l-2*Frame_e, Frame_h]);
        translate ([-Frame_L/2, Frame_l/2-Frame_e,0]) cube([Frame_L, Frame_e, Frame_h]);
        translate ([Frame_L/2-Frame_e, -Frame_l/2+Frame_e,Frame_h-front_h]) cube([Frame_e, Frame_l-2*Frame_e, front_h]);
    }
    color("black") {
        translate ([10,0,Frame_e]) rotate([0,0,90]) text(text = str(Frame_L-Frame_e,"x",Frame_l-2*Frame_e));
        translate ([0,-Frame_l/2,Frame_h/2]) rotate([90,0,0]) text(text = str(Frame_L,"x",Frame_h));
        translate ([-Frame_L/2,0,Frame_h/2]) rotate([90,0,-90]) text(text = str(Frame_l-2*Frame_e,"x",Frame_h));
        translate ([0,Frame_l/2,Frame_h/2]) rotate([90,0,180]) text(text = str(Frame_L,"x",Frame_h));
        translate ([Frame_L/2,0,Frame_h-front_h/2]) rotate([90,0,90]) text(text = str(Frame_l-2*Frame_e,"x",front_h));
    }
}

module railsX() {
    translate_x=Frame_L/2-Frame_e;
    translate_Y=Frame_l/2-coulisse_ec-Frame_e;
    translate_H=Frame_h-coulisse_eh;
    
    color("Silver") translate([translate_x, -translate_Y, translate_H])
        rotate([0,-90,0]) 
            cylinder (d=coulisse_d, h=axe_x, $fn=_globalResolution);
    color("Silver") translate([-translate_x, translate_Y, translate_H])
        rotate([0,90,0]) 
            cylinder (d=coulisse_d, h=axe_x, $fn=_globalResolution);
    
    translate([0, -translate_Y, translate_H])
        rotate([0,90,0]) bagueLaiton_8_12_30();
    translate([0, translate_Y, translate_H])
        rotate([0,90,0]) bagueLaiton_8_12_30();

        
    translate([-Frame_L/2+r608z_e+Frame_e+angle_e+Pulley_GT2_8_e,
        -translate_Y,
        translate_H])
            rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([-Frame_L/2+r608z_e+Frame_e+angle_e+Pulley_GT2_8_e,
        translate_Y,
        translate_H])
            rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([Frame_L/2-r608z_e-Frame_e-angle_e-Pulley_GT2_8_e,
        -translate_Y,
        translate_H])
            rotate([0,90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([Frame_L/2-r608z_e-Frame_e-angle_e-Pulley_GT2_8_e,
        translate_Y,
        translate_H])
            rotate([0,90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
}

module railsY() {
    translate_x=Frame_L/2-coulisse_ec-Frame_e;
    translate_Y=Frame_l/2-Frame_e;
    translate_z=Frame_h-coulisse_eh-coulisse_e;
    
    color("Silver") translate([-translate_x, -translate_Y, translate_z])
        rotate([-90,0,0]) 
            cylinder (d=coulisse_d, h=axe_y, $fn=_globalResolution);
    color("Silver") translate([translate_x, -translate_Y, translate_z])
        rotate([-90,0,0]) 
            cylinder (d=coulisse_d, h=axe_y, $fn=_globalResolution);

    translate([-translate_x, 0, translate_z])
        rotate([90,0,0]) bagueLaiton_8_12_30();
    translate([translate_x, 0, translate_z])
        rotate([90,0,0]) bagueLaiton_8_12_30();
        
    translate([-translate_x,
        -Frame_l/2+r608z_e+Frame_e+angle_e+Pulley_GT2_8_e,
        translate_z])
            rotate([90,0,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([-translate_x,
        Frame_l/2-r608z_e-Frame_e-angle_e-Pulley_GT2_8_e,
        translate_z])
            rotate([-90,0,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([translate_x,
        -Frame_l/2+r608z_e+Frame_e+angle_e+Pulley_GT2_8_e,
        translate_z])
            rotate([90,0,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([translate_x,
        Frame_l/2-r608z_e-Frame_e-angle_e-Pulley_GT2_8_e,
        translate_z])
            rotate([-90,0,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
}

module railsCross() {
    translate_z = Frame_h-coulisse_eh-coulisse_e/2;
    
    color("Silver") translate([-Frame_L/2+coulisse_ec-coulisse_d/2+Frame_e, 0, translate_z+Cross_ec/2])
        rotate([0,90,0]) 
            cylinder (d=coulisse_d, h=Frame_L-2*coulisse_ec+coulisse_d-Frame_e*2, $fn=_globalResolution);
    translate([0, 0, translate_z+Cross_ec/2])
        rotate([0,90,0]) bagueLaiton_8_12_30();
    color("black") translate([-Frame_L/3+coulisse_ec+Frame_e, -5, translate_z+Cross_ec/2+coulisse_d/2])
        rotate([0,0,0]) text(text = str(Frame_L-2*coulisse_ec+coulisse_d-Frame_e*2));
    
    color("Silver") translate([0, Frame_l/2-coulisse_ec+coulisse_d/2-Frame_e, translate_z-Cross_ec/2])
        rotate([90,0,0]) 
            cylinder (d=coulisse_d, h=Frame_l-2*coulisse_ec+coulisse_d-Frame_e*2, $fn=_globalResolution);
    translate([0, 0, translate_z-Cross_ec/2])
        rotate([90,0,0]) bagueLaiton_8_12_30();
    color("black") translate([5, -Frame_l/3+coulisse_ec+Frame_e, translate_z-Cross_ec/2+coulisse_d/2])
        rotate([0,0,90]) text(text = str(Frame_l-2*coulisse_ec+coulisse_d-Frame_e*2));
    
}

module all_rails() {
    railsX();
    railsY();
    railsCross();
}

module all_slicer() {
    translate([Frame_L/2-coulisse_ec-Frame_e, 0, Frame_h-coulisse_eh-coulisse_e]) slicer_withTensioner();
    translate([-Frame_L/2+coulisse_ec+Frame_e, 0, Frame_h-coulisse_eh-coulisse_e]) rotate([0,0,180]) slicer_withTensioner();
    translate([0, Frame_l/2-coulisse_ec-Frame_e, Frame_h-coulisse_eh]) rotate([180,0,90]) slicer_withTensioner();
    translate([0, -Frame_l/2+coulisse_ec+Frame_e, Frame_h-coulisse_eh]) rotate([180,0,-90]) slicer_withTensioner();
    
    translate([0,0,Frame_h-coulisse_eh-coulisse_e/2-Cross_ec/2]) slicer_central();
}

module all_angle() {
    L = coulisse_ec+r608z_D;
    l = coulisse_ec+r608z_D;
    H = angle_h;
    e = angle_e;
    
    translate([Frame_L/2-Frame_e,Frame_l/2-Frame_e,Frame_h]) {
        angle_1(L,l,e,H);
        angle_r608z_1(e,H);
    }
    translate([-Frame_L/2+Frame_e,Frame_l/2-Frame_e,Frame_h]) {
        angle_2(L,l,e,H);
        angle_r608z_2(e,H);
    }
    translate([-Frame_l/2,Frame_L/2+nema17_L/2+e,Frame_h-coulisse_ec]) rotate([-90,0,0]) nema_17();
    
    translate([-Frame_L/2-nema17_L/2-e,Frame_l/2+e,Frame_h-coulisse_ec]) rotate([-90,0,0]) import("../stl/Pulley_GT2_35tooth_5mm.stl");
    translate([-Frame_L/2+coulisse_ec+Frame_e,Frame_l/2+e,Frame_h-coulisse_eh-coulisse_e]) rotate([-90,0,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    
    
    translate([Frame_L/2-Frame_e,-Frame_l/2+Frame_e,Frame_h]) {
        angle_3(L,l,e,H);
        angle_r608z_3(e,H);
    }
    
    translate([-Frame_L/2+Frame_e,-Frame_l/2+Frame_e,Frame_h]) {
        angle_4(L,l,e,H);
        angle_r608z_4(e,H);
    }
    translate([-Frame_L/2,-Frame_l/2-nema17_L/2-e,Frame_h-coulisse_ec]) rotate([0,-90,0]) nema_17();
    
    translate([-Frame_L/2-e,-Frame_l/2-nema17_L/2-e,Frame_h-coulisse_ec]) rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_5mm.stl");
    translate([-Frame_L/2-e,-Frame_l/2+coulisse_ec+Frame_e,Frame_h-coulisse_eh]) rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
}

module belt(l,r) {
    color("black") union() {
        translate([-l/2,0,r]) rotate([-90,0,0]) belt_len(profile = 0, belt_width = GT2_w, len = l);
        translate([-l/2,0,-r]) rotate([90,0,0]) belt_len(profile = 0, belt_width = GT2_w, len = l);
        translate([-l/2,0,-r]) rotate([90,0,180]) belt_angle(profile = 0, rad=r, bwdth= GT2_w, angle=180, fn=_globalResolution);
        translate([+l/2,0,-r]) rotate([90,0,0]) belt_angle(profile = 0, rad=r, bwdth= GT2_w, angle=180, fn=_globalResolution);
    }
}

module belt_x() {
    l = Frame_L-2*coulisse_ec-2*Frame_e;
    L = -Frame_l/2+Frame_e+r608z_e+Pulley_GT2_8_tooth_w+GT2_w;
    h = Frame_h-coulisse_eh-coulisse_e;
    translate([0,L,h]) belt(l, Pulley_GT2_8_D/2);
    translate([0,-L,h]) belt(l, Pulley_GT2_8_D/2);
}

module belt_y() {
    l = Frame_l-2*coulisse_ec-2*Frame_e;
    L = -Frame_L/2+Frame_e+r608z_e+Pulley_GT2_8_tooth_w+GT2_w;
    h = Frame_h-coulisse_eh;
    translate([L,0,h]) rotate([0,0,90]) belt(l, Pulley_GT2_8_D/2);
    translate([-L,0,h]) rotate([0,0,90])belt(l, Pulley_GT2_8_D/2);
}

module all_belt() {
    belt_x();
    belt_y();
}

module all() {
    //frame();
    all_rails();
    
    all_angle();
    
    all_slicer();
    
    all_belt();
    
    //translate([0,-Frame_l/2+Frame_e,Frame_e]) rotate([0,0,90]) axeZ(Frame_h-(coulisse_e+coulisse_eh+r608z_D));
    //translate([0,+Frame_l/2-Frame_e,Frame_e]) rotate([0,0,-90]) axeZ(Frame_h-(coulisse_e+coulisse_eh+r608z_D));
}

all();


