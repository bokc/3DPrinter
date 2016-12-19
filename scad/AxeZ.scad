include <Param.scad>;

use <Bearing.scad>
use <Nema_17.scad>;

module axeZ(H) {
    axe_central_x = nema17_L/2+1;
    entraxe = (Frame_l-2*Frame_e-2*coulisse_ec)/4;
    
    //color("green") translate([0,7,10]) import("../stl/Smartcore_Threaded_Z_Base_-_Part_1.stl");
    //color("green") translate([18.5,-13,H/2]) rotate([0,0,90]) import("../stl/Smartcore_Threaded_Z_Parts_-_Part_1.stl");
    //color("green") translate([22,0,H-10]) import("../stl/Smartcore_Threaded_Z_Top_-_Part_1.stl");

    

    color("Silver") translate([axe_central_x,-entraxe,0]) cylinder(d=8, h=H);
    translate([axe_central_x,-entraxe,H/2+15]) bagueLaiton_8_12_30();
    
    color("Silver") translate([axe_central_x,entraxe,0]) cylinder(d=8, h=H);
    translate([axe_central_x,entraxe,H/2+15]) bagueLaiton_8_12_30();
    
    translate([axe_central_x,0,H-r608z_e]) bearing608z();
    translate([axe_central_x,0,nema17_h+2]) nema_17();
    color("green") fixBas(e=3, entraxe=entraxe, axe_central_x=axe_central_x);
}

module fixBas(e, entraxe, axe_central_x) {
    h=nema17_h+2;
    l=nema17_L+1;
    union() {
        translate([0,0,h]) fix_nema(e, h, l);
        translate([0,nema17_L/2+0.5,0]) cube([l, e, h+e]);
        translate([0,-nema17_L/2-0.5-e,0]) cube([l, e, h+e]);
        fix_axe_bas(l, entraxe, e, axe_central_x);
        mirror([0,1,0]) fix_axe_bas(l, entraxe, e, axe_central_x);
    }
}

module fix_axe_bas(l, entraxe, e, axe_central_x) {
    difference() {
        translate([0,nema17_L/2,0]) cube([l,entraxe, e]);
        translate([axe_central_x,entraxe,-0.1]) cylinder(d=8, h=e+0.2, $fn=_globalResolution);
    }
    //translate([0,-nema17_L/2-entraxe,0]) cube([l,entraxe, e]);
}

module fix_nema(e, h, l) {
    r_fix=22;
    translate([nema17_L/2+1/2,0,e/2]) difference() {
        cube([l, nema17_L+1, e], center=true);
        for(i=[0:3]) {
           translate([cos(45+90*i)*r_fix+0.5, sin(45+90*i)*r_fix]) cylinder(d=Vis_m3_p, h=e+0.1, center=true,$fn=_globalResolution);
        }
        translate([0.5,0,0])cylinder(d=25, h=e+0.1, center=true,$fn=_globalResolution);
    }
}

axeZ(170);