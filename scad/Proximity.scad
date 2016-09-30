module LJ18A3_8_Z(){
    d=18;
    l=10;
    D=20;
    L=70;
    translate([0,0,0]) cylinder(d=d,h=l,$fn=32);
    color("silver") translate([0,0,l]) cylinder(d=D,h=L,$fn=32);
}

LJ18A3_8_Z();