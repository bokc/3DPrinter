include <Param.scad>;

module fanRadial() {
    d=48.5;
    h=Fan_radial_e_h;
    fix_r=3.5;
    fix_R=65/2-fix_r;
    color("dimgrey")
        difference() {
            union() {
                cylinder(d=d,h=h, $fn=_globalResolution);
                translate([d/4,Fan_radial_e_l/2-d/2,h/2]) cube([d/2+1,Fan_radial_e_l, h], center=true);
                translate([-cos(45)*(fix_R),-sin(45)*(fix_R),0]) {
                    cylinder(r=fix_r,h=h , $fn=_globalResolution);
                    rotate([0,0,45]) translate([0,-fix_r,0]) cube([10,fix_r*2,h]);
                }
                translate([+cos(45)*(fix_R),+sin(45)*(fix_R),0]) {
                    cylinder(r=fix_r,h=h , $fn=_globalResolution);
                    rotate([0,0,-135]) translate([0,-fix_r,0]) cube([10,fix_r*2,h]);
                }
        }
        translate([d/4,Fan_radial_e_l/2-d/2,h/2]) cube([d/2+1.2,Fan_radial_e_l-2, h-2], center=true);
        translate([-cos(45)*(fix_R),-sin(45)*(fix_R),-0.1]) cylinder(d=4.5,h=h+0.2 , $fn=_globalResolution);
        translate([+cos(45)*(fix_R),+sin(45)*(fix_R),-0.1]) cylinder(d=4.5,h=h+0.2 , $fn=_globalResolution);
        translate([3,2,1.1]) difference() {
            cylinder(r=14, h=h-1);
            cylinder(r=12, h=h);
            };
    }
}

fanRadial();