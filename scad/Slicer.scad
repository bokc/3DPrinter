include <Param.scad>;
use <Bearing.scad>;

module slicer_axe() {
    translate([0,BagueLaiton_L,0]) rotate([90,0,0])
        cylinder(d=8,h=BagueLaiton_L*2,$fn=_globalResolution );
    rotate([90,0,0]) bagueLaiton_8_12_30();
    
    translate([-BagueLaiton_L*2+coulisse_d/2,0,coulisse_e/2+Cross_ec/2]) rotate([0,90,0])
        cylinder(d=8,h=BagueLaiton_L*2,$fn=_globalResolution );
}

module slicer() {
    L = BagueLaiton_D + 10;
    h = Cross_ec+BagueLaiton_D;
    
    bas_d=BagueLaiton_D+4;
    bas_l=BagueLaiton_L + 2*2;
    haut_d=coulisse_d+4;
    haut_l = coulisse_d*3;
    
    difference() {
        hull() {
            translate([0,bas_l/2,0]) rotate([90,0,0])
                cylinder(d=bas_d,h=bas_l,$fn=_globalResolution );
            translate([-haut_l+bas_d/2,0,coulisse_e/2+Cross_ec/2]) rotate([0,90,0])
                cylinder(d=haut_d,h=haut_l,$fn=_globalResolution );
        }
        slicer_axe();
    }
    
    
}

slicer();