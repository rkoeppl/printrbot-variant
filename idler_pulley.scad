include <wallace.scad>;
difference() {
	intersection() {
		linear_extrude(height = idler_pulley_width + 1, convexity = 5) difference() {
			circle(pulley_size / 2 + 2);
			circle(5, $fn = 4);
		}
		union() {
			translate([0, 0, idler_pulley_width / 2 + 1]) scale([1, 1, 1.25]) sphere(pulley_size / 2);
			cylinder(r = pulley_size / 2 + 5, h = 1);
		}
	}
	for(h = [-idler_pulley_width + 4, idler_pulley_width * 2 + 1 - 4]) rotate(180 / 8) translate([0, 0, (double_bearing) ? h:0]) cylinder(r = 10 * da8, h = idler_pulley_width * 2, center = true, $fn = 8);
}