include <Param.scad>;

use <Nema_17.scad>;
use <Nema17Fix.scad>;
use <AxeZ.scad>;
use <Bearing.scad>
include <Angle.scad>;

module frame(Frame_L, Frame_l , Frame_h, Frame_e) {
    front_h=100;
    translate ([-Frame_L/2, -Frame_l/2,0]) cube([Frame_L, Frame_l, Frame_e]);
    translate ([-Frame_L/2, -Frame_l/2,Frame_e]) cube([Frame_L, Frame_e, Frame_h-Frame_e]);
    translate ([-Frame_L/2, -Frame_l/2+Frame_e,Frame_e]) cube([Frame_e, Frame_l-2*Frame_e, Frame_h-Frame_e]);
    translate ([-Frame_L/2, Frame_l/2-Frame_e,Frame_e]) cube([Frame_L, Frame_e, Frame_h-Frame_e]);
    translate ([Frame_L/2-Frame_e, -Frame_l/2+Frame_e,Frame_h-front_h]) cube([Frame_e, Frame_l-2*Frame_e, front_h]);
}

module coulissesX(d, Frame_L, frame_h, Frame_l, Frame_e) {
    espace_haut=coulisse_eh;
    espace_cote=coulisse_ec;
    
    translate_x=Frame_L/2;
    translate_Y=Frame_l/2-espace_cote-Frame_e;
    
    color("Silver") translate([-translate_x, -translate_Y, frame_h-espace_haut])
        rotate([0,90,0]) 
            cylinder (d=d, h=Frame_L, fn=_globalResolution);
    color("Silver") translate([-translate_x, translate_Y, frame_h-espace_haut])
        rotate([0,90,0]) 
            cylinder (d=d, h=Frame_L, fn=_globalResolution);

    color("Silver") translate([-translate_x+espace_cote-d/2+Frame_e, 0, frame_h-espace_haut])
        rotate([0,90,0]) 
            cylinder (d=d, h=Frame_L-2*espace_cote+d-Frame_e*2, fn=_globalResolution);
    
    translate([0, -translate_Y, frame_h-espace_haut])
        rotate([0,90,0]) bagueLaiton_8_12_30();
    translate([0, translate_Y, frame_h-espace_haut])
        rotate([0,90,0]) bagueLaiton_8_12_30();
    translate([0, 0, frame_h-espace_haut])
        rotate([0,90,0]) bagueLaiton_8_12_30();
}

module coulissesY(d, Frame_L, frame_h, Frame_l, Frame_e, coulisse_e) {
    espace_haut=coulisse_eh+coulisse_e;
    espace_cote=coulisse_ec;
    
    translate_x=Frame_l/2-espace_cote-Frame_e;
    translate_Y=Frame_L/2;
    
    color("Silver") translate([-translate_x, translate_Y, frame_h-espace_haut])
        rotate([90,0,0]) 
            cylinder (d=d, h=Frame_L, fn=_globalResolution);
    color("Silver") translate([translate_x, translate_Y, frame_h-espace_haut])
        rotate([90,0,0]) 
            cylinder (d=d, h=Frame_L, fn=_globalResolution);

    color("Silver") translate([0, translate_Y-espace_cote+d/2-Frame_e, frame_h-espace_haut])
        rotate([90,0,0]) 
            cylinder (d=d, h=Frame_L-2*espace_cote+d-Frame_e*2, fn=_globalResolution);
    
    translate([-translate_x, 0, frame_h-espace_haut])
        rotate([90,0,0]) bagueLaiton_8_12_30();
    translate([translate_x, 0, frame_h-espace_haut])
        rotate([90,0,0]) bagueLaiton_8_12_30();
    translate([0, 0, frame_h-espace_haut])
        rotate([90,0,0]) bagueLaiton_8_12_30();
}

module all_coulisse(Frame_L, Frame_l, Frame_h, coulisse_d, Frame_e, coulisse_e) {
    coulissesX(coulisse_d, Frame_L, Frame_h, Frame_l, Frame_e);
    coulissesY(coulisse_d, Frame_l, Frame_h, Frame_L, Frame_e, coulisse_e);
}

module all_angle(batis_H,batis_L, batis_l, batis_e) {
    L = coulisse_ec+r608z_D;
    l = coulisse_ec+r608z_D;
    H = coulisse_e+coulisse_eh+r608z_D;
    e = 5;
    
    translate([batis_L/2-batis_e,batis_l/2-batis_e,batis_H]) {
        angle_1(L,l,e,H);
        angle_r608z_1(e,H);
    }
    translate([-batis_L/2+batis_e,batis_l/2-batis_e,batis_H]) {
        angle_2(L,l,e,H);
        angle_r608z_2(e,H);
    }
    
    translate([-batis_L/2+batis_e,-batis_l/2+batis_e,batis_H]) {
        angle_4(L,l,e,H);
        angle_r608z_4(e,H);
    }
    translate([batis_L/2-batis_e,-batis_l/2+batis_e,batis_H]) {
        angle_3(L,l,e,H);
        angle_r608z_3(e,H);
    }
    
    translate([-batis_L/2,-batis_l/2-nema17_L/2-e,batis_H-coulisse_ec]) rotate([0,-90,0]) nema_17();
    
    translate([-batis_L/2-e,-batis_l/2-nema17_L/2-e,batis_H-coulisse_ec]) rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_5mm.stl");
    translate([-batis_L/2-e,-batis_l/2+coulisse_ec+batis_e,batis_H-coulisse_ec]) rotate([0,-90,0]) import("../stl/Pulley_GT2_35tooth_8mm.stl");
}

module all(Frame_L, Frame_l, Frame_h, Frame_e, coulisse_d, coulisse_e) {
    color("BurlyWood") frame(Frame_L,Frame_l,Frame_h,Frame_e);
    all_coulisse(Frame_L, Frame_l, Frame_h, coulisse_d, Frame_e, coulisse_e);
    
    all_angle(Frame_h, Frame_L, Frame_l,Frame_e);
    
    translate([0,-Frame_l/2+Frame_e,Frame_e]) rotate([0,0,90]) axeZ(Frame_h-(coulisse_e+coulisse_eh+r608z_D));
    translate([0,+Frame_l/2-Frame_e,Frame_e]) rotate([0,0,-90]) axeZ(Frame_h-(coulisse_e+coulisse_eh+r608z_D));
}

all(Frame_L, Frame_l, Frame_h, Frame_e, coulisse_d, coulisse_e);

translate ([Frame_L/2 + 30, 0 , 0]) {
    bearing608z();
}
translate ([Frame_L/2 + 50, 0 , 0]) {
    lm8uu();
}
translate ([Frame_L/2 + 70, 0 , 0]) {
    bagueLaiton();
}

translate ([Frame_L/2 + 100, 0 , 0]) {
    nema_17();
}
translate ([Frame_L/2 + 140, 0 , 0]) {
import("../stl/Pulley_GT2_35tooth_5mm.stl");
}

translate ([Frame_L/2 + 170, 0 , 0]) {
import("../stl/Pulley_GT2_35tooth_5mm.stl");
}

