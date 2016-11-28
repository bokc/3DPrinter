include <Param.scad>;
use <Bearing.scad>;
use <Proximity.scad>;
use <fan.scad>;
use <fanRadial.scad>;
use <head_cooler.scad>;
use <tools/e3d_v6_chimera.scad>;

module head_axe_central() {
    L = BagueLaiton_L*3;
    //bas
    union() {
        translate([0,L/2,0]) rotate([90,0,0])
            cylinder(d=coulisse_d+1,h=L,$fn=_globalResolution );
        translate([0,BagueLaiton_L/2-BagueLaiton_D/2,0]) rotate([90,0,0]) bagueLaiton_8_12_30();
    }
    //haut
    union() {
        translate([-L/2,0,Cross_ec]) rotate([0,90,0])
            cylinder(d=coulisse_d+1,h=L,$fn=_globalResolution );
        translate([BagueLaiton_L/2-BagueLaiton_D/2,0,Cross_ec])rotate([0,90,0]) bagueLaiton_8_12_30();
    }
}

module head_central() {
    bas_d=BagueLaiton_D+5;
    bas_l=BagueLaiton_L + 2*2;
    
    difference() {
        hull() {
            difference() {    
                color("blue") hull() {
                    //bas
                    translate([0,bas_l-BagueLaiton_D/2-2,0]) rotate([90,0,0])
                        cylinder(d=bas_d,h=bas_l,$fn=_globalResolution );
                    //haut
                    translate([-BagueLaiton_D/2-2,0,Cross_ec]) rotate([0,90,0])
                        cylinder(d=bas_d,h=bas_l,$fn=_globalResolution );
                    
                };

                //Coupe basse
                translate([-bas_d, -BagueLaiton_D/2-2-0.5,-bas_d/2-1.5]) cube([bas_d*2, bas_l+1, bas_d/2]);
                //Coupe Haute
                translate([-BagueLaiton_D/2-2-0.5, -bas_d,Cross_ec+1.5]) cube([bas_l+5, bas_d*2, bas_d/2]);
            }
            // Fixation E3D
            translate([Head_x-10, Head_y-15,Head_z-1.5]) {
                cube([22, 30, 4]);
            }
            // Fixation Capteur
            translate([-BagueLaiton_D/2-20/2-4, -coulisse_d/2-5-20/2,-1.5]) {
                cylinder(d=20, l=5);
            }
        }
        //Coupe Haute
        translate([-BagueLaiton_D/2-2-0.5, -(BagueLaiton_D)/2-3,Cross_ec+1.5]) cube([bas_l+5, BagueLaiton_D+3, bas_d/2]);
        head_axe_central();
        translate([Head_x, Head_y,Head_z-1.5]) rotate([0,0,90]) e3d_fix();
        translate([Head_x-6, Head_y-15,Head_z-30-1.5]) cube([18,30,30]);
        translate([-BagueLaiton_D/2-20/2-4, -coulisse_d/2-5-20/2,Head_z-25]) rotate([0,0,90]) LJ12A3_4_Z();
        
    }
    
}

module e3d_fix() {
    //vis Haut
    translate([8.5,-9,-0.1]) cylinder(d=Vis_m3_p,h=30,$fn=_globalResolution );
    translate([8.5,-9,4]) cylinder(d=Vis_m3_t,h=30,$fn=_globalResolution );
    translate([-8.5,-9,-0.1]) cylinder(d=Vis_m3_p,h=30,$fn=_globalResolution );
    translate([-8.5,-9,4]) cylinder(d=Vis_m3_t,h=30,$fn=_globalResolution );
    translate([0,3,-0.1]) cylinder(d=Vis_m3_p,h=30,$fn=_globalResolution );
    translate([0,3,4]) cylinder(d=Vis_m3_t,h=30,$fn=_globalResolution );
    
    //bowden
    translate([9,0,-0.1]) cylinder(d=10,h=30,$fn=_globalResolution );
    translate([-9,0,-0.1]) cylinder(d=10,h=30,$fn=_globalResolution );
    
    //vis arriere
    //translate([4.5,6+30-0.1,-10]) rotate([90,0,0]) cylinder(d=Vis_m3_p,h=30,$fn=_globalResolution );
    //translate([-4.5,6+30-0.1,-10]) rotate([90,0,0]) cylinder(d=Vis_m3_p,h=30,$fn=_globalResolution );

    //pour control
    //translate([0,-0,-30]) e3d();
}

module head_central_with_e3d() {
    head_central();
    color("silver") translate([Head_x,Head_y,Head_z-30-1.5]) rotate([0,0,90]) e3d();
    translate([-BagueLaiton_D/2-20/2-4, -coulisse_d/2-5-20/2,Head_z-48]) rotate([0,0,90]) LJ12A3_4_Z();
    translate([10/2+Head_x+12, 30/2+Head_y-15, Head_z-30/2-1.5]) rotate([0,90,0]) fan(30, 10, 24, 3.2, 3,-45);
    translate([Head_x+ 3,Head_y ,Head_z-45]) head_fan();
}

module head_fan() { 
    //color ("red") rotate([180,0,-90]) import("../stl/Chimera_Part_Cooling_Duct.stl");
    color ("red") rotate([0,0,90]) headCooler();
    translate([-66,-11,16]) rotate([0,180,180]) fanRadial();
    
}

//    head_fan();
head_central_with_e3d();
//e3d_fix();
