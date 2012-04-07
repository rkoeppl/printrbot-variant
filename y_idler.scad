include <wallace.scad>;
difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			square([rod_size * 2, motor_casing + rod_size * 2], center = true);
			for(side = [1, -1]) translate([0, side * (motor_casing / 2 + rod_size), rod_size / 2 + bearing_size / 2]) rotate(180 / 8) circle(rod_size * 13/12, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
		}
		for(side = [1, -1]) translate([0, side * (motor_casing / 2 + rod_size), rod_size / 2 + bearing_size / 2]) rotate(180 / 8) circle(rod_size * da8, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);

	}
	rotate([90, 0, 90]) {
		for(side = [1, -1]) translate([side * (motor_casing / 2 - rod_size / 2), 5, -3]) {
			cylinder(r = m3_size * da6, h = rod_size * 2, center = true, $fn = 6);
			translate([0, 0, rod_size]) cylinder(r = m3_nut_size * da6, h = 4, $fn = 6);
		}
	
}
}