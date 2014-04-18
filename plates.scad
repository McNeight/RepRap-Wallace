include <wallace.scad>;
bed_size_x=130;
bed_size_y=130;

!translate() {

	translate() {
		%cube([bed_size_x,bed_size_y,0.1], center=true);
		translate([20,-30,0]) base_end(0);
		translate([-32,-30,0]) base_end(1);
		translate([3,10,0]) rotate() x_end(0);
		translate([32,40,0]) rotate([0,0,-90]) x_end(1);
		translate([-50,30,0]) rotate([0,0,90]) y_bearing_retainer();
		translate([-15,43,0]) rotate([0,0,90]) y_idler();
	}

	translate([bed_size_x+5,0,0]) {
		%cube([130,130,0.1], center=true);
		x_carriage();
		translate([-48,38,0]) rotate([0,0,90]) bed_mount();
		translate([-32,33,0]) rotate([0,0,90]) bed_mount();
		translate([13,32,0]) rotate([0,0,90]) bed_mount();
		translate([53,42,0]) rotate([0,0,90]) bed_mount();
		translate([60,-38,0]) rotate([0,0,90]) belt_clamp();
		translate([50,-15,0]) rotate([0,0,90]) mirror([0,1,0]) belt_clamp();
		translate([46,-50,rod_size/2 + 4]) rotate([-90,0,90]) foot();
		translate([52,2,rod_size / 2 + 4]) rotate([-90,0,90]) foot();
		translate([-58,26,5]) rotate([0,0,90]) y_bearing_retainer_slim();
		translate([-35,60,5]) rotate([0,0,180]) mirror([0,1,0]) y_bearing_retainer_slim();
	}

}

