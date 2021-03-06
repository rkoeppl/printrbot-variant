include <wallace.scad>;
difference() {
	linear_extrude(height = rod_size, convexity = 5) difference() {
		minkowski() {
			square(rod_size + 2, center = true);
			circle(rod_size, $fn = 16);
		}
		circle(rod_size / 2, $fn = 12);
	}
	translate([0, 0, -rod_size / 16]) cylinder(r1 = rod_size * 3/4, r2 = rod_size / 4, h = rod_size / 2, $fn = 12);
	translate([0, 0, rod_size / 2 + rod_size / 16]) cylinder(r2 = rod_size * 3/4, r1 = rod_size / 4, h = rod_size / 2, $fn = 12);
}