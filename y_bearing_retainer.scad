include <config.scad>;

//y bearing retainers for printing
translate([bearing_size / 4, bearing_size - (bearing_size * 2/3), 0]) rotate(180) y_bearing_retainer();

//y bearing retainer module
module y_bearing_retainer() difference() {
	intersection() {
	difference() {
		linear_extrude(height = motor_screw_spacing + 10, convexity = 5) difference() {
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
		for(rh=[1,0]) for(side = [1, -1]) translate([side * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2,0, rh*motor_screw_spacing + 5]) rotate(90) rotate([90, 0, 90]) {
			cylinder(r = 3 * 7/12, h = bearing_size, center = true, $fn = 6);
			translate([0, 0, bearing_size * sqrt(2) / 4 - 5]) rotate([180, 0, 0]) cylinder(r = 3, h = bearing_size, $fn = 30);
		}
	}
	for(sides=[1,0]) translate([0, 0,sides* (motor_screw_spacing) + 5]) rotate(90) rotate([90, 0, 90]) cylinder(r = (yz_motor_distance + motor_casing - motor_screw_spacing + 10) / 2, h = bearing_size + 10, center = true, $fn = 6);
}
	translate([6,5,motor_screw_spacing/2+5]) rotate([90]) cylinder(h=20,r=4);
	rotate([30, 0, 0])  translate([-(bearing_size + 10) / 2 - bearing_size / 2, -10.5, 0]) cube([bearing_size + 10, 10, motor_screw_spacing / 2 + 7]);
	translate([0, 0, motor_screw_spacing + 10]) mirror([0, 0, 1]) rotate([30, 0, 0])  translate([-(bearing_size + 10) / 2 - bearing_size / 2, -10.5, 0]) cube([bearing_size + 10, 10, motor_screw_spacing / 2 + 7]);
}


