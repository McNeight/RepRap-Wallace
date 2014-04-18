include <config.scad>;

x_carriage();

module x_carriage() difference() {
	union() {
		intersection() {
			difference() {
				union() {
					translate([0,0,x_carriage_width/2]) cube([bearing_size + 8, x_rod_spacing,x_carriage_width], center = true);
					translate([0, -x_rod_spacing / 2 - bearing_size / 2 + 8 + pulley_size / 2+4.5, 0]) cube([bearing_size / 2 + 4 + 15, x_rod_spacing / 2 + bearing_size / 2 + 0 - 12,x_carriage_width]);
					translate([0, pulley_size / 2+2.5, 0]) {
						cube([bearing_size / 2 + 4 + 15, 8,x_carriage_width]);
						translate([bearing_size / 2 + 4 + 15, 4, 0]) cylinder(r=4,h=x_carriage_width);
					}
					rotate(180) translate([-bearing_size / 2 - 4, -x_rod_spacing / 2 - bearing_size / 2 - carriage_top, 0]) cube([bearing_size + 8 + 8, bearing_size / 2 + 4 + carriage_top,x_carriage_width]);
					for(side = [1, -1]) translate([0, side * x_rod_spacing / 2, 0]) cylinder(r=bearing_size / 2 + 4, h=x_carriage_width, $fn = 24);
				}
				translate([bearing_size / 2 + 4, 2 + pulley_size / 2+2.5, 0]) {
					cube([15, 4,x_carriage_width]);
					translate([0, -3, 0]) cube([2, 4,x_carriage_width]);
					translate([15, 2, 0]) cylinder(r=2,h=x_carriage_width);
				}
				for(side=[1,-1]) translate([0, side * x_rod_spacing / 2, 0]) cylinder(r=bearing_size / 2, h=x_carriage_width, $fn = 6);
				translate([0, -x_rod_spacing / 2, 0]) rotate(90 * 0) cube([2, bearing_size / 2 + 20,x_carriage_width]);
			}
			difference() {
				rotate([0, -90, 0]) linear_extrude(height = bearing_size + 50, convexity = 5, center = true) difference() {
					polygon([
						[
							0,
							(x_rod_spacing / 2 + bearing_size / 2 + carriage_top)
						],[
							0,
							-(x_rod_spacing / 2 + bearing_size / 2 + 4)
						],[
							bearing_length + 4,
							-(x_rod_spacing / 2 + bearing_size / 2 + 4)
						],[
							bearing_length + 4,
							-(x_rod_spacing / 2 - bearing_size / 2 - 4)
						],[
							x_carriage_width,
							(x_rod_spacing / 2 - bearing_size / 2 - 4)
						],[
							x_carriage_width,
							(x_rod_spacing / 2 + bearing_size / 2 + carriage_top)
						]
					]);
				}
				translate([bearing_size / 2 + 4, -50, bearing_length - 5]) cube(100);
			
			}
		}
	}
	// linear bearings
	translate([0, x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
		//%translate([0, 0, 20]) rotate(180 / 8) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
		for(end = [0, 1]) mirror([0, 0, end]) translate([0, 0, end * -x_carriage_width - 1]) cylinder(r = bearing_size / 2, h = bearing_length, $fn = 30);
	}
	translate([0, -x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
		translate([0, 0, 4]) cylinder(r = bearing_size / 2, h = x_carriage_width + 1, center = false, $fn = 24);
		//%translate([0, 0,20]) rotate(180 / 8) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
	}
	// screw holes
	translate([bearing_size / 2 + 4 + 10, 5 - pulley_size + 11, bearing_length / 2 - 2]) rotate([90, 0, 0]) {
		cylinder(r = m3_size * da6, h = x_rod_spacing + bearing_size + 10, center = true, $fn = 6);
		rotate([180, 0, 0]) cylinder(r = m3_size * da6 * 2, h = x_rod_spacing + bearing_size + 10, center = false, $fn = 6);
		translate([0, 0, x_rod_spacing / 2 + bearing_size / 2 + 6 - 2*pulley_size]) cylinder(r = m3_nut_size * da6, h = x_rod_spacing + bearing_size + 10, center = false, $fn = 6);
	}
	translate([0,0,x_carriage_width/2]) rotate([0,90,0]) {
		cylinder(r = m3_size * da6, h = x_rod_spacing + bearing_size + 60, center = true, $fn = 6);
		translate([0,0,-bearing_size / 2+1]) rotate([180, 0, 0]) cylinder(r = m3_size * da6 * 2, h = bearing_size, center = false, $fn = 6);
	}
	//extruder mounting
	translate([-x_carriage_width/3-bearing_size/2-4,x_rod_spacing/2+bearing_size/2+x_carriage_width/2+6+2,x_carriage_width/2]) rotate([90,0,0]) rotate([0,0,22.5]) cylinder(r=(x_carriage_width/3)/cos(22.5),h=60,$fn=8);
	translate([-bearing_size/2-4-4,x_rod_spacing/2+bearing_size/2+6,x_carriage_width/2])
		rotate([90,0,0]) rotate([0,0,22.5]) cylinder(r=6,h=60);
	for(i=[1,-1]) translate([-(bearing_size/2+4+4),0,x_carriage_width/2+i*(x_carriage_width/2-4)]) rotate([-90,0,0]) {
		cylinder(r=3.3/2,h=60,$fn=12);
	}
	translate([-bearing_size/2-4-10-(5.8/sqrt(3))/2,x_rod_spacing/2-4,-0.1]) cube([10,3,x_carriage_width+0.2]);
}

