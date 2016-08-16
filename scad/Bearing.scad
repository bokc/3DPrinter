include <Param.scad>;
use <Linear_Bearing.scad>;

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
    
module bagueLaiton_8_12_30() {
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

bearing608z();
translate([20,0,0]) lm8uu();
translate([40,0,0]) bagueLaiton_8_12_30();