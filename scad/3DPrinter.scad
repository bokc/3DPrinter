include <Param.scad>;

use <Nema_17.scad>;
use <Nema17Fix.scad>;
use <AxeZ.scad>;
use <Bearing.scad>
use <Angle.scad>;

module frame() {
    front_h=100;
    translate ([-Frame_L/2, -Frame_l/2,0]) cube([Frame_L, Frame_l, Frame_e]);
    translate ([-Frame_L/2, -Frame_l/2,Frame_e]) cube([Frame_L, Frame_e, Frame_h-Frame_e]);
    translate ([-Frame_L/2, -Frame_l/2+Frame_e,Frame_e]) cube([Frame_e, Frame_l-2*Frame_e, Frame_h-Frame_e]);
    translate ([-Frame_L/2, Frame_l/2-Frame_e,Frame_e]) cube([Frame_L, Frame_e, Frame_h-Frame_e]);
    translate ([Frame_L/2-Frame_e, -Frame_l/2+Frame_e,Frame_h-front_h]) cube([Frame_e, Frame_l-2*Frame_e, front_h]);
}

module coulissesX() {
    translate_x=Frame_L/2;
    translate_Y=Frame_l/2-coulisse_ec-Frame_e;
    translate_y=Frame_h-coulisse_eh;
    
    color("Silver") translate([translate_x, -translate_Y, translate_y])
        rotate([0,-90,0]) 
            cylinder (d=coulisse_d, h=axe_x, fn=_globalResolution);
    color("Silver") translate([-translate_x, translate_Y, translate_y])
        rotate([0,90,0]) 
            cylinder (d=coulisse_d, h=axe_x, fn=_globalResolution);

    color("Silver") translate([-translate_x+coulisse_ec-coulisse_d/2+Frame_e, 0, translate_y])
        rotate([0,90,0]) 
            cylinder (d=coulisse_d, h=Frame_L-2*coulisse_ec+coulisse_d-Frame_e*2, fn=_globalResolution);
    
    translate([0, -translate_Y, translate_y])
        rotate([0,90,0]) bagueLaiton_8_12_30();
    translate([0, translate_Y, translate_y])
        rotate([0,90,0]) bagueLaiton_8_12_30();
    translate([0, 0, translate_y])
        rotate([0,90,0]) bagueLaiton_8_12_30();
        
    translate([-Frame_L/2+r608z_e+Frame_e+angle_e+Pulley_GT2_8_e,
        -translate_Y,
        translate_y])
            rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([-Frame_L/2+r608z_e+Frame_e+angle_e+Pulley_GT2_8_e,
        translate_Y,
        translate_y])
            rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([Frame_L/2-r608z_e-Frame_e-angle_e-Pulley_GT2_8_e,
        -translate_Y,
        translate_y])
            rotate([0,90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
    translate([Frame_L/2-r608z_e-Frame_e-angle_e-Pulley_GT2_8_e,
        translate_Y,
        translate_y])
            rotate([0,90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
}

module coulissesY() {
    translate_x=Frame_L/2-coulisse_ec-Frame_e;
    translate_Y=Frame_l/2;
    translate_z=Frame_h-coulisse_eh-coulisse_e;
    
    color("Silver") translate([-translate_x, -translate_Y, translate_z])
        rotate([-90,0,0]) 
            cylinder (d=coulisse_d, h=axe_y, fn=_globalResolution);
    color("Silver") translate([translate_x, -translate_Y, translate_z])
        rotate([-90,0,0]) 
            cylinder (d=coulisse_d, h=axe_y, fn=_globalResolution);

    color("Silver") translate([0, translate_Y-coulisse_ec+coulisse_d/2-Frame_e, translate_z])
        rotate([90,0,0]) 
            cylinder (d=coulisse_d, h=Frame_l-2*coulisse_ec+coulisse_d-Frame_e*2, fn=_globalResolution);
    
    translate([-translate_x, 0, translate_z])
        rotate([90,0,0]) bagueLaiton_8_12_30();
    translate([translate_x, 0, translate_z])
        rotate([90,0,0]) bagueLaiton_8_12_30();
    translate([0, 0, translate_z])
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

module all_coulisse() {
    coulissesX();
    coulissesY();
}

module all_angle() {
    L = coulisse_ec+r608z_D;
    l = coulisse_ec+r608z_D;
    H = coulisse_e+coulisse_eh+r608z_D;
    e = angle_e;
    
    translate([Frame_L/2-Frame_e,Frame_l/2-Frame_e,Frame_h]) {
        angle_1(L,l,e,H);
        angle_r608z_1(e,H);
    }
    translate([-Frame_L/2+Frame_e,Frame_l/2-Frame_e,Frame_h]) {
        angle_2(L,l,e,H);
        angle_r608z_2(e,H);
    }
    
    translate([-Frame_L/2+Frame_e,-Frame_l/2+Frame_e,Frame_h]) {
        angle_4(L,l,e,H);
        angle_r608z_4(e,H);
    }
    translate([Frame_L/2-Frame_e,-Frame_l/2+Frame_e,Frame_h]) {
        angle_3(L,l,e,H);
        angle_r608z_3(e,H);
    }
    
    translate([-Frame_L/2,-Frame_l/2-nema17_L/2-e,Frame_h-coulisse_ec]) rotate([0,-90,0]) nema_17();
    
    translate([-Frame_L/2-e,-Frame_l/2-nema17_L/2-e,Frame_h-coulisse_ec]) rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_5mm.stl");
    translate([-Frame_L/2-e,-Frame_l/2+coulisse_ec+Frame_e,Frame_h-coulisse_eh]) rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
}

module all() {
    color("BurlyWood") frame();
    all_coulisse();
    
    all_angle();
    
    translate([0,-Frame_l/2+Frame_e,Frame_e]) rotate([0,0,90]) axeZ(Frame_h-(coulisse_e+coulisse_eh+r608z_D));
    translate([0,+Frame_l/2-Frame_e,Frame_e]) rotate([0,0,-90]) axeZ(Frame_h-(coulisse_e+coulisse_eh+r608z_D));
}

all();

translate ([Frame_L/2 + 30, 0 , 0]) {
    bagueLaiton_8_12_30();
}

translate ([Frame_L/2 + 70, 0 , 0]) {
    nema_17();
}
translate ([Frame_L/2 + 120, 0 , 0]) {
import("../stl/Pulley_GT2_35tooth_5mm.stl");
}

translate ([Frame_L/2 + 150, 0 , 0]) {
import("../stl/Pulley_GT2_35tooth_8mm.stl");
}

