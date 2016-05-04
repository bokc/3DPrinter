use <Linear_Bearing.scad>;
use <Nema_17.scad>;

r608z_d=8;
r608z_D=22;
r608z_e=7;

Frame_L = 400;
Frame_l = 500;
Frame_h = 400;
Frame_e = 16;
coulisse_d = 8;
coulisse_e = 2*coulisse_d;
coulisse_eh = r608z_D+5;
coulisse_ec = r608z_D+5;

nema17_L=42;
nema17_axe_d=5.2;


_globalResolution = 16;

module frame(Frame_L, Frame_l , Frame_h, Frame_e) {
    front_h=100;
    translate ([-Frame_L/2, -Frame_l/2,0]) cube([Frame_L, Frame_l, Frame_e]);
    translate ([-Frame_L/2, -Frame_l/2,Frame_e]) cube([Frame_L, Frame_e, Frame_h-Frame_e]);
    translate ([-Frame_L/2, -Frame_l/2+Frame_e,Frame_e]) cube([Frame_e, Frame_l-2*Frame_e, Frame_h-Frame_e]);
    translate ([-Frame_L/2, Frame_l/2-Frame_e,Frame_e]) cube([Frame_L, Frame_e, Frame_h-Frame_e]);
    translate ([Frame_L/2-Frame_e, -Frame_l/2+Frame_e,Frame_h-front_h]) cube([Frame_e, Frame_l-2*Frame_e, front_h]);
}

module bearing608z(){
    color("Silver")
    difference(){
        cylinder(d=r608z_D,h=r608z_e,fn=_globalResolution);
        translate ([0,0, -0.05]) cylinder(d=r608z_d,h=r608z_e+0.1,fn=_globalResolution);
    };
}

module lm8uu() {
    color("Silver")
    linear_bearing("LM-8-UU");
}
    
module bagueLaiton() {
    d=8;
    D=12;
    l=30;
    color("Goldenrod")
    translate ([0,0,-l/2])
    difference(){
        cylinder(d=D,h=l,fn=_globalResolution);
        translate ([0,0, -0.05]) cylinder(d=d,h=l+0.1,fn=_globalResolution);
    };
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
        rotate([0,90,0]) bagueLaiton();
    translate([0, translate_Y, frame_h-espace_haut])
        rotate([0,90,0]) bagueLaiton();
    translate([0, 0, frame_h-espace_haut])
        rotate([0,90,0]) bagueLaiton();
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
        rotate([90,0,0]) bagueLaiton();
    translate([translate_x, 0, frame_h-espace_haut])
        rotate([90,0,0]) bagueLaiton();
    translate([0, 0, frame_h-espace_haut])
        rotate([90,0,0]) bagueLaiton();
}

module all_coulisse(Frame_L, Frame_l, Frame_h, coulisse_d, Frame_e, coulisse_e) {
    coulissesX(coulisse_d, Frame_L, Frame_h, Frame_l, Frame_e);
    coulissesY(coulisse_d, Frame_l, Frame_h, Frame_L, Frame_e, coulisse_e);
}
    
module angle_1(L,l,e,H) {
    retour_h = 15;
    translate([-L,-l,-H]) {
        color("Red") difference(){
            union() {
                difference(){
                    union() {
                        cube([L,l,H]);
                        translate([0,0,H]) cube([L+Frame_e+e,l+Frame_e+e,e]);
                        translate([L+Frame_e,0,H-retour_h]) cube([e,l+Frame_e+e,retour_h]);
                        translate([0,l+Frame_e,H-retour_h]) cube([L+Frame_e+e,e,retour_h]);
                    }
                    translate([-0.1,-0.1,-0.05]) cube([L-e+0.1,l-e+0.1,H+e+0.1]);
                }
                translate([L-e,l-coulisse_ec, H-coulisse_eh]) rotate([0,-90,0]) cylinder(h = r608z_e+0.1, d1 = r608z_D*1.7, d2 = r608z_D*1.2);
                translate([L-coulisse_ec,l-e, H-coulisse_eh-coulisse_e]) rotate([90,0,0]) cylinder(h = r608z_e+0.1, d1 = r608z_D*1.7, d2 = r608z_D*1.2);
            }
            
            translate([L-coulisse_ec,0.05+l, H-coulisse_eh-coulisse_e]) rotate([90,0,0]) cylinder(d=coulisse_d+1, h=L+0.1, fn=_globalResolution);
            translate([-0.05,l-coulisse_ec, H-coulisse_eh]) rotate([0,90,0]) cylinder(d=coulisse_d*1.2, h=L+0.1, fn=_globalResolution);
            
            translate([L-e,l-coulisse_ec, H-coulisse_eh]) rotate([0,-90,0]) cylinder(d=r608z_D,h=r608z_e+0.2,fn=_globalResolution);
            translate([L-coulisse_ec,l-e, H-coulisse_eh-coulisse_e]) rotate([90,0,0]) cylinder(d=r608z_D,h=r608z_e+0.2,fn=_globalResolution); 
        }
    }
}

module angle_r608z_1(e,H) {
    translate([-e,-coulisse_ec, -coulisse_eh]) rotate([0,-90,0]) bearing608z();
    translate([-coulisse_ec,-e, -coulisse_eh-coulisse_e]) rotate([90,0,0]) bearing608z();
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
            translate([-Frame_e-e,-Frame_e-e-nema17_L,-nema17_L-e*2]) cube([e,l+e+Frame_e+nema17_L,nema17_L+e*3]);
            translate([-Frame_e,-nema17_L/2-e-Frame_e,-coulisse_ec]) rotate([0,-90,0]) cylinder(d=6,h=+e+0.2,fn=_globalResolution);
            translate([-Frame_e-2*e,l-coulisse_ec+e, -coulisse_ec]) rotate([0,90,0]) cylinder(d=coulisse_d*1.2, h=L+0.1, fn=_globalResolution);
        }
    }
}

module angle_r608z_4(e,H) {
    mirror([1,0,0]) mirror([0,1,0]) angle_r608z_1(e,H);
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
}

module all(Frame_L, Frame_l, Frame_h, Frame_e, coulisse_d, coulisse_e) {
    //color("BurlyWood") frame(Frame_L,Frame_l,Frame_h,Frame_e);
    //all_coulisse(Frame_L, Frame_l, Frame_h, coulisse_d, Frame_e, coulisse_e);
    
    all_angle(Frame_h, Frame_L, Frame_l,Frame_e);
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

