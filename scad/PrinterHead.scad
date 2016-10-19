include <Param.scad>;
use <Bearing.scad>;
use <Proximity.scad>;
use <fan.scad>;
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

                translate([-bas_d, -BagueLaiton_D/2-2-0.5,-bas_d/2-1.5]) cube([bas_d*2, bas_l+1, bas_d/2]);
                translate([-BagueLaiton_D/2-2-0.5, -bas_d,Cross_ec+1.5]) cube([bas_l+1, bas_d*2, bas_d/2]);
            }
            translate([BagueLaiton_D/2, coulisse_d/2+3,-1.5]) {
                cube([22, 30, 4]);
            }
            translate([-BagueLaiton_D/2-26/2, coulisse_d/2+5+26/2,-1.5]) {
                cylinder(d=26, l=5);
            }
        }
        head_axe_central();
        translate([BagueLaiton_D+4, coulisse_d/2+18,-1.5]) rotate([0,0,90]) e3d_fix();
        translate([-BagueLaiton_D/2-26/2, coulisse_d/2+5+26/2,-25]) rotate([0,0,90]) LJ18A3_8_Z();
        
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
    color("silver") translate([BagueLaiton_D+4,coulisse_d/2+18,-30-1.5])  rotate([0,0,90]) e3d();
    translate([-BagueLaiton_D/2-26/2, coulisse_d/2+5+26/2,-48]) rotate([0,0,90]) LJ18A3_8_Z();
    translate([15/2+BagueLaiton_D/2+22, 30/2+coulisse_d/2+3, -30/2-1.5]) rotate([0,90,0]) fan(30, 15, 24, 3.2, 3,-45);
}

module head_fan() { 
    h=20;
    l = 36;
    L =30;
    e=2;
    space = 4;
    difference() {
        linear_extrude(height = h, center = true, convexity = 10, scale=[1,3], $fn=100) circle(d=l);
        translate([-l/2-0.1,-L/2,-h/2-0.1]) cube([l+0.2,L,h+0.2]);
        translate([0, 0, e]) linear_extrude(height = h, center = true, convexity = 10, scale=[1,3], $fn=100)  circle(d=l);
        translate([0, 0, e]) cylinder(d=l+e*2, h=h*2, center = true, $fn=_globalResolution);
    }
    
    difference() {
        linear_extrude(height = h, center = true, convexity = 10, scale=[1,2], $fn=100) circle(d=l-e-space);
        translate([-l/2-0.1,-L/2-space/2,-h/2-0.1]) cube([l+0.2,L+space,h+0.2]);
        translate([0, 0, e]) linear_extrude(height = h, center = true, convexity = 10, scale=[1,2], $fn=100)  circle(d=l-e-space);
    }
}

//translate([16,22,-60]) 
    head_fan();
//head_central_with_e3d();
//e3d_fix();
