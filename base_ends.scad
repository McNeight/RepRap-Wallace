include <config.scad>;

!base_end();

module base_end(single=0) translate([-z_rod_offset,0,0]) difference() {
	linear_extrude(height = end_height + single * 2, convexity = 5) difference() {
		square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, motor_casing + rod_size * 3 + 2], center = true);
		for(end = [1, -1]) {
			for(side = [1, -1]) translate([end * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, side * motor_screw_spacing / 2, 0]) polycircle(m3_size / 2);
			translate([end * (yz_motor_distance + motor_casing) / 2, 0, 0]) circle(motor_screw_spacing / 2);
		}
	}
	//chamfers
	for(chamfer=[1, 0]) mirror([chamfer, 0, 0]) translate([23.5, -(motor_casing + 2 * rod_size) / 2 - rod_size, 15]) rotate([0, -40, 0]) cube([4 * rod_size, motor_casing + rod_size * 4, end_height]);
	translate([1 * (yz_motor_distance + motor_casing) / 2, 0, 3]) linear_extrude(height = end_height, convexity = 5) square(motor_casing, center = true);
	translate([-1 * (yz_motor_distance + motor_casing * 2 / 3) / 2-1, 0,4]) linear_extrude(height = end_height, convexity = 5) square(motor_casing, center = true);
	for(side = [1, -1]) translate([0, side * (motor_casing / 2 + 5), rod_size / 2 + bearing_size / 2]) rotate([90, 180 / 8, 90]) {
		cylinder(r = rod_size * da8, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
		%translate([0, 0, -70]) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
	}
	//Z smooth rod bore
	translate([z_rod_offset, 0, 0]) {
		translate([0,0,10]) difference() {
			cube([rod_size * da8 * 2 + 8, rod_size * da8 * 2 + 8, end_height - motor_casing / 4], center = true);
			cube([rod_size * da8 * 2 + 6, rod_size * da8 * 2 + 6, end_height - motor_casing / 4], center = true);
		}
		linear_extrude(height = end_height * 9 / 16, convexity = 5) rotate(180 / 8) circle(rod_size * da8, $fn = 8);
		translate([0,0,4]) cube([rod_size * da8 * 2 + 8,1,8], center = true);
		 //z axis clamping
		translate([0, 0, 3]) {
			for(h = [0,1]) rotate([0,0,180 * h]) rotate([90, 0, 0]) translate([0, 0, rod_size / 2 + 8]) {
				rotate([0, 0, 30]) cylinder(r = m3_nut_size / sqrt(3), h = 4, $fn = 6);
				translate([0, -4, 2]) cube([m3_nut_size, 8, 4], center = true);
				translate([0, 0, -4]) rotate([0, 0, 22.5]) cylinder(r = m3_size* da8, h = yz_motor_distance + motor_casing, $fn = 8);
			}
		}
	}
	if(single==0){
		translate([0, 0, end_height]) scale([1, 1, 0.5]) rotate([90, 0, 90]) cylinder(r = motor_casing / 2, h = yz_motor_distance + 20, center = true);
		translate([-yz_motor_distance / 2 + bearing_size / 2, 0, -bearing_size * sqrt(2) / 4]) rotate([90, -45, 0]) {
			%cylinder(r = rod_size * 13/24, h = 100, center = true, $fn = 8);
			for(side = [0, 1]) mirror([0, 0, side]) translate([0, 0, rod_size / 2 + 7]) {
				cylinder(r = bearing_size / 2, h = bearing_length, center = false, $fn = 10);
				cube([bearing_size / 2, bearing_size / 2, bearing_length]);
			}
		}
	}else{
		translate([-yz_motor_distance / 2 + bearing_size / 2, 0, -bearing_size * sqrt(2) / 4]) rotate([90, -45, 0]) {
			%cylinder(r = rod_size * 13/24, h = motor_casing + rod_size * 3 + 2 + y_travel + 20, center = true, $fn = 8);
			translate([0, 0, -bearing_length/2]) {
				cylinder(r = bearing_size / 2, h = bearing_length, center = false, $fn = 10);
				cube([bearing_size / 2, bearing_size / 2, bearing_length]);
			}
		}
		for(i=[1,-1]) translate([0,i*(motor_casing/2+rod_size *3/4),end_height /2 +3*rod_size]) cube([yz_motor_distance*2,rod_size*4,end_height], center=true);
		for(side = [1, -1]) translate([-1 * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, side * motor_screw_spacing / 2, 3]) cylinder(r=m3_nut_size * da6, h=4, $fn = 6);
	//holes for endstop
	for(side=[1,-1]) translate([side * 9.5 / 2 + z_rod_offset + 9.5, motor_casing / 2 + rod_size / 2 + 4, -1]) rotate([0,0,0]) polyhole(2.8/2,10);//cylinder(r=2.8/2,h=10);
	}
	translate([0, 0, end_height - rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod_size * da8, h = motor_casing + rod_size * 5, $fn = 8, center = true);
	%translate([0, 0, end_height - rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod_size * da8, h = 100, $fn = 8, center = true);
}


