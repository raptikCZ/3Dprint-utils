// names in Czech 
// values tested with properly configured skeinforge

//screws diameter
m3 = 3.1;
m4 = 4.1;
m5 = 5.1;
m6 = 6.2;
m8 = 8.1;

//when you need make own threaded hole
m3_zavit = 2.4;
m4_zavit = 3.2;
m5_zavit = 5 * 0.8;
m6_zavit = 4.8;
m8_zavit = 6.8;

//washers [diameter, height]
m3_podlozka =[6.9,0.5];
m6_podlozka =[13,1.5];
m8_podlozka = [16,1.5];

//nuts [diameter of hexagonal top, height of nut or hole for nut]
m3_matka = [6.45,2.5];
m5_matka = [9.3,3.8];
m8_matka = [14.52,6.2];

//nema 17 dimensions
nema17_roztec_srouby = 31; // pitch of mounting screws 
nema17_priruba = [22,2]; // circular plate at axis output if any [diameter, height]
nema17_rozmer = 42.3; // square dimension of body ( X = Y )
nema17_sroubky = m3; // mounting screws
nema17_axis = [5,25]; // dimension of motor axis [diameter, length]

//nema17 in one array
nema17 = [nema17_rozmer,nema17_priruba,nema17_roztec_srouby,nema17_sroubky,nema17_axis];

lm8uu = [12,25];
lm10uu = [19,29];
lm10luu = [19,55];

bearing_623 = [3,10,4];
