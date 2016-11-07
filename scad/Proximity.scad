module LJ18A3_8_Z(){
    d=18;
    l=10;
    D=20;
    L=70;
    translate([0,0,0]) cylinder(d=d,h=l,$fn=32);
    color("silver") translate([0,0,l]) cylinder(d=D,h=L,$fn=32);
}

module LJ12A3_4_Z(){
    d=10.6;
    l=5.3;
    D=12;
    L=44;
    translate([0,0,0]) cylinder(d=d,h=l,$fn=32);
    color("silver") translate([0,0,l]) cylinder(d=D,h=L,$fn=32);
}


LJ12A3_4_Z();