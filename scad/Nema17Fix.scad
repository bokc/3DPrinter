use <clavette.scad>;

module nema_fixation(epaisseur = 6, longueur = 10, def = 25) {
    translate([-epaisseur-0.1,longueur,0]) rectangle_Arrondi(longueur,epaisseur+0.2,6, def);
    translate([-epaisseur-0.1,longueur,0]) union() {
                translate([0,15.5,15.5]) rectangle_Arrondi(longueur,epaisseur+0.2,3.2, def);
                translate([0,-15.5,15.5]) rectangle_Arrondi(longueur,epaisseur+0.2,3.2, def);
                translate([0,15.5,-15.5]) rectangle_Arrondi(longueur,epaisseur+0.2,3.2, def);
                translate([0,-15.5,-15.5]) rectangle_Arrondi(longueur,epaisseur+0.2,3.2, def);
        };
 }
    
 nema_fixation();