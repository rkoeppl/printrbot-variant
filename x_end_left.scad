include<wallace.scad>;
// ratio for converting diameter to apothem
da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;
m8_dia=8;
m8_nut=16;
m4_dia=4;
m4_nut=7;
difference() {
	union() {
		 
		      translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2 - motor_casing, 8 + rod_size, 0]) rotate([90, 0, 0]) {
			// Motor holder
			linear_extrude(height = 7) difference() {
				square([motor_casing + 3, x_rod_spacing + 8 + rod_size]);
				translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 4, 0]) {
					circle(motor_screw_spacing / 2);
					for(x = [1, -1]) for(y = [1, -1]) translate([x * motor_screw_spacing / 2, y * motor_screw_spacing / 2, 0]) circle(m3_size * da6, $fn = 6);
					translate([-(motor_casing * 1.5 - motor_screw_spacing), (motor > 1) ? (motor_casing / 2 - motor_screw_spacing) : 0, 0]) square([motor_casing, x_rod_spacing + 8 + rod_size]);
				}
			}
			// Belt
			%translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 4, rod_size / 2 - 2 - bearing_size / 2 - 2 - idler_pulley_width / 2]) rotate([180, 0, 0]) linear_extrude(height = 5, convexity = 5) difference() {
				union() {
					circle(pulley_size / 2 + 2);
					translate([0, -pulley_size / 2 - 2, 0]) square([200.5, pulley_size + 4]);
					translate([200.5, 0, 0]) circle(pulley_size / 2 + 2);
				}
				circle(pulley_size / 2);
				translate([0, -pulley_size / 2, 0]) square([200.5, pulley_size]);
				translate([200.5, 0, 0]) circle(pulley_size / 2);
			}

		}
		linear_extrude(height = x_rod_spacing + 8 + rod_size, convexity = 5) difference() {
			union() {
				for(side = [1, -1]) translate([side * (motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 + 3, $fn = 30);
				square([motor_casing / 2 + rod_size, bearing_size / 2 + 3], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, 0, 0]) square([(motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3) / 2, bearing_size / 2 + 4 + rod_size / 2]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, 0, 0]) square([motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3, bearing_size / 2 + 3 + rod_size / 2]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, 0, 0]) square([(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + 5 - rod_size / 2 - 2, bearing_size / 2 + 6 + rod_size]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, bearing_size / 2 + rod_size / 2 + 4, 0]) circle(rod_size / 2 + 2);
				
			}
			square([motor_casing / 2 + rod_size, 1], center = true);
			translate([(motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 - .5, $fn = 30);
			translate([-(motor_casing / 4 + rod_size / 2), 0, 0]) circle(rod_nut_size * 6/14, $fn = 6);
			translate([4 + rod_size / 2, bearing_size / 2 + rod_size / 2 + 3, 0]) {
				square([motor_casing / 2 + rod_size + bearing_size + 8, 1], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2, .5, 0]) circle(rod_size / 4 + .5, $fn = 12);
			}
		}
	}
	translate([0, 0, (x_rod_spacing + rod_size + 8) / 2]) {
		for(end = [0, 1]) mirror([0, 0, end]) translate([motor_casing / 4 + rod_size / 2, 0, -(x_rod_spacing + rod_size + 8) / 2 - 1]) cylinder(r = bearing_size / 2 - .05, h = bearing_length, $fn = 30);
		for(side = [1, -1]) render(convexity = 5) translate([0, bearing_size / 2 + rod_size / 2 + 3, side * x_rod_spacing / 2]) rotate([0, 90, 0]) {
			
			difference() {
				translate([0, 0, (motor > -1) ? rod_size / 2 + 2 : 0]) intersection() {
					rotate(45) cube([rod_size + 2, rod_size + 2, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
					cube([rod_size * 2, rod_size + 2, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
				}
				translate([0, rod_size, 0]) cube([rod_size * 2, rod_size * 2, 6], center = true);
				for(end = [ -1]) translate([0, -rod_size, end * (motor_casing / 4 + rod_size / 2)]) cube([rod_size * 2, rod_size * 2, 6], center = true);
			}
			translate([0, 0, rod_size / 2 + 2]) intersection() {
				rotate(45) cube([rod_size, rod_size, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
				cube([rod_size * 2, rod_size + 1, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
			}
		}
		// holes for clamping screws
		translate([0,0,(x_rod_spacing-30)/2]){
		rotate([90, 0, 0]) {
			cylinder(r = m4_dia/2, h = 100, center = true, $fn = 12);
			translate([0, 0, bearing_size / 4 + .5]) cylinder(r = m4_nut * da6, h = 100, center = false, $fn = 6);
		}
                }
		translate([0,0,-(x_rod_spacing-30)/2]){
		rotate([90, 0, 0]) {
			cylinder(r = m4_dia/2, h = 100, center = true, $fn = 12);
			translate([0, 0, bearing_size / 4 + .5]) cylinder(r = m4_nut * da6, h = 100, center = false, $fn = 6);
		}
                }
	}
	translate([-(motor_casing / 4 + rod_size / 2), 0, 5]) rotate(90) cylinder(r = rod_nut_size / 2, h = x_rod_spacing + 8 + rod_size, $fn = 6);
	translate([(motor_casing / 4 + rod_size / 2), 0, 5]) %rotate(180 / 8) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
}
