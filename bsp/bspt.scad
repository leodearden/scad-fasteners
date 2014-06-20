// A module library for creating B(ritish) S(tandard) P(ipe) T(hread) shaped solids

eps = 0.01;
//eps = 1;
eps2 = 2 * eps;

bsp_taper_ratio = 1/16;
bsp_eighth_major_d = 9.728;
bsp_eighth_minor_d = 8.565;
bsp_eighth_mid_d = (bsp_eighth_major_d + bsp_eighth_minor_d)/2;
bsp_eighth_gauge_l = 4;
bsp_eighth_l = 7.5;

function BSPT_start_r(diameter, gauge_length) = 
	(diameter - gauge_length * bsp_taper_ratio) / 2;

function BSPT_end_r(diameter, length, gauge_length) = 
	(diameter + (length - gauge_length) * bsp_taper_ratio) / 2;

module BSPT(diameter, length, gauge_length) {
	cylinder(r1 = BSPT_end_r(diameter, length, gauge_length),
	         r2 = BSPT_start_r(diameter, gauge_length),
	         h = length);
}

//BSPT(bsp_eighth_mid_d, bsp_eighth_l, bsp_eighth_gauge_l);

module BSPT_female(diameter, length, gauge_length, wall_t = 3) {
	difference() {
		cylinder(r = BSPT_end_r(diameter, length, gauge_length) + wall_t,
		         h = length);
		translate([0, 0, length + eps]) {
			rotate([180, 0, 0]) BSPT(diameter, length + eps2, gauge_length + eps);
		}
	}
}

//BSPT_female(bsp_eighth_mid_d, bsp_eighth_l, bsp_eighth_gauge_l);