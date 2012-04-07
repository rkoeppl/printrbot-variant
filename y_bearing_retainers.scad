include <wallace.scad>;
// ratio for converting diameter to apothem
da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;
intersection() {
	difference() {
		linear_extrude(height = 10, convexity = 5) difference() {
			union() {
				intersection() {
					translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2 + 4);
					translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, -bearing_size, 0]) square([bearing_size + 8, bearing_size]);
				}
				translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, 0, 0]) square([bearing_size + 8, bearing_size * sqrt(2) / 4 - 1]);
				translate([0, bearing_size * sqrt(2) / 4 - 3, 0]) square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, 4], center = true);
			}
			translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2);
			translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2, 0, 0]) square(bearing_size);
		}
		//screw holes
		for(side = [1, -1]) translate([side * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, 0, 5]) rotate(90) rotate([90, 0, 90]) {
			cylinder(r = m3_size * da6, h = bearing_size, center = true, $fn = 6);
			translate([0, 0, bearing_size * sqrt(2) / 4 - 5]) rotate([180, 0, 0]) cylinder(r = m3_size, h = bearing_size, $fn = 30);
		}
	}
	translate([0, 0, 5]) rotate(90) rotate([90, 0, 90]) cylinder(r = (yz_motor_distance + motor_casing - motor_screw_spacing + 10) / 2, h = bearing_size + 10, center = true, $fn = 6);
}