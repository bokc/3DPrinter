module rectangle_Arrondi(L = 40, l = 6, H = 6, def=25){
    translate([l,H/2,0]) rotate([0,-90,0]) cylinder(d=H,h=l,$fn=def);
    translate([l,L+H/2,0]) rotate([0,-90,0]) cylinder(d=H,h=l,$fn=def);
    translate([0,H/2,-H/2]) cube([l,L, H]);
}

rectangle_Arrondi(40,6,10);
color("red") translate([0,10/2-4/2,10/2+4/2]) rectangle_Arrondi(40,6,4);