include <Param.scad>;

use <Bearing.scad>

module axeZ(H) {
    color("green") translate([0,7,10]) import("../stl/Smartcore_Threaded_Z_Base_-_Part_1.stl");
    color("green") translate([18.5,-13,H/2]) rotate([0,0,90]) import("../stl/Smartcore_Threaded_Z_Parts_-_Part_1.stl");
    color("green") translate([22,0,H-10]) import("../stl/Smartcore_Threaded_Z_Top_-_Part_1.stl");

    //translate([16.5,-60.1-20,H/2+15]) bagueLaiton_8_12_30();

    color("Silver") translate([16.5,-60.1,0]) cylinder(d=8, h=H);
    color("Silver") translate([16.5,60.1,0]) cylinder(d=8, h=H);
    translate([22,0,H-r608z_e]) bearing608z();
}

axeZ(150);