
module cone_r608z(D=22*1.7, d=22*1.2, h=7+0.1, def=25){
    r608z_d=8;
    r608z_D=22;
    r608z_e=7;
    
    difference() {
        cylinder(h = h, d1 = D, d2 = d, $fn=def);
        translate([0,0,-0.1]) cylinder(d=r608z_D,h=r608z_e+0.3,$fn=def);
    }
    
}

cone_r608z();
