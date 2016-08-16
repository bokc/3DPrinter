
//axe : disponible : 320*2/350*2/370*2/470*4/405*2
axe_x = 350;
axe_y = 405;
axe_z = 370;

Frame_e = 16;
coulisse_d = 8;
angle_e=5;

// Constant
r608z_d=8;
r608z_D=22;
r608z_e=7;

nema17_L=42;
nema17_axe_d=5.2;

Pulley_GT2_8_e=17;
Pulley_GT2_8_D=26;

BagueLaiton_D=12;

_globalResolution = 64;

// Data
Frame_L = axe_x-Pulley_GT2_8_e-angle_e;
Frame_l = axe_y-Pulley_GT2_8_e-angle_e;
Frame_h = axe_z;

coulisse_e = 3*coulisse_d;
coulisse_eh = r608z_D+5;
coulisse_ec = r608z_D+12;

angle_h=coulisse_e+coulisse_eh+r608z_D;
