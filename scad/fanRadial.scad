include <Param.scad>;

module fanRadial() {
    d=50;
    h=Fan_radial_e_h;
    fix_r=3;
    color("dimgrey")
        difference() {
            union() {
                cylinder(d=d,h=h, $fn=_globalResolution);
                translate([d/4,Fan_radial_e_l/2-d/2,h/2]) cube([d/2,Fan_radial_e_l, h], center=true);
                translate([-cos(45)*(d/2+fix_r),-sin(45)*(d/2+fix_r),0]) cylinder(r=fix_r,h=2 , $fn=_globalResolution);
                translate([+cos(45)*(d/2+fix_r),+sin(45)*(d/2+fix_r),0]) cylinder(r=fix_r,h=2 , $fn=_globalResolution);
        }
        translate([d/4,Fan_radial_e_l/2-d/2,h/2]) cube([d/2+0.2,Fan_radial_e_l-2, h-2], center=true);
        translate([-cos(45)*(d/2+fix_r),-sin(45)*(d/2+fix_r),-0.1]) cylinder(d=Vis_m3_p,h=2.2 , $fn=_globalResolution);
        translate([+cos(45)*(d/2+fix_r),+sin(45)*(d/2+fix_r),-0.1]) cylinder(d=Vis_m3_p,h=2.2 , $fn=_globalResolution);
    }
}

fanRadial();