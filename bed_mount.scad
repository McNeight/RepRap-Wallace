include <config.scad>;

!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -7.5, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();

module bed_mount() difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			rotate(180 / 8) circle((rod_size + 8) * da8, $fn = 8);
			translate([0, -rod_size / 2 - 4, 0]) square([rod_size / 2 + 8, max(rod_size + 8, rod_size / 2 + 4 + bed_mount_height)]);
		}
		rotate(180 / 8) circle(rod_size * da8, $fn = 8);
		translate([0, -rod_size / (1 + sqrt(2)) / 2, 0]) square([rod_size + 10, rod_size / (1 + sqrt(2))]);
	}
	translate([rod_size / 2 + 1.5, -rod_size / 2 - 6, 5]) rotate([-90, 0, 0]) {
		cylinder(r = m3_size/2, h = max(rod_size + 12, rod_size / 2 + 7 + bed_mount_height), $fn = 12);
		cylinder(r = m3_nut_size / sqrt(3), h = 4, $fn = 6);
	}
}


