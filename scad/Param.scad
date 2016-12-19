
//axe : disponible : 320*2/350*2/370*2/470*4/405*2
axe_x = 470;
axe_y = 470;
axe_z = 370;

Frame_e = 16;
coulisse_d = 8;
angle_e=3.5;

// Constant
r608z_d=8;
r608z_D=22;
r608z_e=7;

nema17_L=42;
nema17_axe_d=5.2;
nema17_h=40;

Pulley_GT2_8_e=17.5;
Pulley_GT2_8_D=26;
Pulley_GT2_8_tooth_w=6.2;

GT2_w=6;

BagueLaiton_D=12;
BagueLaiton_L=30;

Vis_m3_p = 3.2;
Vis_m3_t = 5;

Head_x = BagueLaiton_D/2+12;
Head_y = coulisse_d/2+20;
Head_z = 20;

Fan_radial_e_h=15;
Fan_radial_e_l=19.2;

// resolution of round object. each line segment is fnr mm long. fnr = 1 crude and good for development (its faster), aim for fnr = 0.4 or smaller for a production render. smaller means more details (and a lot more time to render).
resolution = 0.4;
// detail level
detaillevel = 1; // [0:coarse render only outlines,1:fine render with all details]
// 
withfan = 0; // [0:render without fan frame,1:render with fan frame]

_globalResolution = 20;

// Data
Frame_L = axe_x-Pulley_GT2_8_e-angle_e+Frame_e;
Frame_l = axe_y-Pulley_GT2_8_e-angle_e+Frame_e;
Frame_h = axe_z;

coulisse_e = 3*coulisse_d+1;
coulisse_eh = (r608z_D*1.7)/2+4;
coulisse_ec = r608z_D+10;

Cross_ec = BagueLaiton_D+1;

angle_h=coulisse_e+coulisse_eh+r608z_D;
