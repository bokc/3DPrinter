include <Param.scad>;
use <Bearing.scad>;
use <tools/timing_belts.scad>;

module slicer_axe() {
    translate([0,BagueLaiton_L,0]) rotate([90,0,0])
        cylinder(d=coulisse_d+1,h=BagueLaiton_L*2,$fn=_globalResolution );
    rotate([90,0,0]) bagueLaiton_8_12_30();
    
    translate([-BagueLaiton_L*2+BagueLaiton_D/2+5,0,coulisse_e/2+Cross_ec/2]) rotate([0,90,0])
        cylinder(d=coulisse_d,h=BagueLaiton_L*2,$fn=_globalResolution );
}

module fixBas() {
    h = 4;
    translate([0,h/2,0]) rotate([90,0,0])
    difference() {
        cylinder(d=BagueLaiton_D+4,h=h,$fn=_globalResolution );
        translate([0,0,-0.1]) cylinder(d=BagueLaiton_D+2,h=h+0.2,$fn=_globalResolution );
    }
}

module gt2tensioner_cors(L = 20, l=12, h=7) {
    translate([2,0,2]) minkowski() {
        cube([l-4,L-1,h-4]);
        rotate([-90,0,0])cylinder(r=2,h=1, $fn=_globalResolution);
    }
}

module gt2tensioner(L = 20, l=12, h=7) {
    difference() {
        color("red") gt2tensioner_cors(L, l ,h);
        translate([Vis_m3_p,-0.1,h/2]) rotate([-90,0,0]) cylinder(d=Vis_m3_p, h=L+0.2,$fn=_globalResolution);
        translate([9+0.1,-0.1,h/2]) rotate([-90,0,90]) belt_len(profile = 0, belt_width = 6, len = L+0.2);
    }
    
}

module slicer() {
    L = BagueLaiton_D + 10;
    h = Cross_ec+BagueLaiton_D;
    
    bas_d=BagueLaiton_D+5;
    bas_l=BagueLaiton_L + 2*2;
    haut_d=coulisse_d+4;
    haut_l = coulisse_d*2;
    
    difference() {
        color("blue") union() {
            hull() {
                //bas
                translate([0,bas_l/2,0]) rotate([90,0,0])
                    cylinder(d=bas_d,h=bas_l,$fn=_globalResolution );
                //haut
                translate([-haut_l+bas_d/2,0,coulisse_e/2+Cross_ec/2]) rotate([0,90,0])
                    cylinder(d=haut_d,h=haut_l,$fn=_globalResolution );
            };
            translate([-haut_l+bas_d/2,1,coulisse_e/2+Cross_ec/2+coulisse_d/2+1]) cube([haut_l,2,5]);
            translate([-haut_l+bas_d/2,-3,coulisse_e/2+Cross_ec/2+coulisse_d/2+1]) cube([haut_l,2,5]);
            // GT2
            translate([0,-bas_l/2,h/2]) cube([14, bas_l, 10]);
        };
        slicer_axe();
        translate([-haut_l+bas_d/2-0.1,-1,coulisse_e/2+Cross_ec/2-coulisse_d/2+0.1]) cube([haut_l+0.2,2,haut_d]);
        //vis
        translate([-haut_l/2+bas_d/2,coulisse_d/2,coulisse_e/2+Cross_ec/2+haut_d/2+Vis_m3_p/2]) rotate([90,0,0]) cylinder(d=Vis_m3_p, h=coulisse_d, $fn=_globalResolution);
        
        translate([-bas_d/2-2,-bas_l/2-0.1,-bas_d*0.55]) cube([bas_d+2, bas_l+0.2,bas_d/2]);
        
        translate([0,haut_l*1/3,0]) fixBas();
        translate([0,-haut_l*1/3,0]) fixBas();
        
        //GT2
        translate([11+0.1,-bas_l/2-0.1,h/2+5]) rotate([-90,0,90]) belt_len(profile = 0, belt_width = 6, len = bas_l/2+0.2);
        translate([0.75,-0.1,h/2+1.5]) gt2tensioner_cors(bas_l/2+0.2, 12.5, 7.5);
        translate([Vis_m3_p+0.75,0.1,h/2+7.5/2+Vis_m3_p/2]) rotate([90,0,0]) cylinder(d=Vis_m3_p, h=L+0.2,$fn=_globalResolution);
    }
}

module slicer_withTensioner() {
    slicer();
    translate([0.87,0,Cross_ec/2+BagueLaiton_D/2+1.75]) gt2tensioner();
}

slicer_withTensioner();

