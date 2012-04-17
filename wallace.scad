include <config.scad>

use <barrel_retainer.scad>
use <base_ends.scad>;
use <bed_mount.scad>;
use <bed_plate.scad>;
use <belt_clamp.scad>;
use <extruder_drive.scad>;
use <foot.scad>;
use <x_carriage.scad>;
use <x_ends.scad>;
use <y_bearing_retainer.scad>;
use <y_bearing_retainer_slim.scad>;
use <y_idler.scad>;

echo("y smooth rod length = ",(motor_casing + rod_size * 3 + 2 + y_travel + 20));
echo("x smooth rod length = ", (x_travel+x_carriage_width+80-5));
echo("M6 base bars = ", 200);

//The following section positions parts for rendering the assembled machine.
//
//base ends
translate([0, 0, -bearing_size]) rotate([0, 180, 0]) base_end(0);
translate([x_travel + x_carriage_width + bearing_size + 6, 0, -bearing_size]) rotate([0, 180,180]) base_end(1);
//y bearing retainers
for(end = [1, -1])
	translate([z_rod_offset, end * -(motor_screw_spacing / 2 + 5), -bearing_size + bearing_size * sqrt(2) / 4])
			mirror([0, (end == 1) ? 1 : 0, 0]) rotate([-90, 0, 180]) y_bearing_retainer_slim();
translate([x_travel + x_carriage_width + 6 + 3 * rod_size - yz_motor_distance / 2, -(motor_screw_spacing / 2 + 5), -bearing_size + bearing_size * sqrt(2) / 4]) rotate([-90, 0, 0])
	y_bearing_retainer();
//bed mounts
for(end=[0, 1]) {
	for(side = [0, 1])
		translate([end * (x_travel + x_carriage_width + bearing_size + 6 - (yz_motor_distance / 2 + z_rod_offset + bearing_size / 2)), 0, 0])
			mirror([0, side, 0]) {
				translate([yz_motor_distance / 2 - bearing_size / 2 + z_rod_offset, -(motor_casing + rod_size * 3 + 2) / 2 - y_travel / 2, -bearing_size + bearing_size * sqrt(2) / 4])
					rotate(end==1?[-90, 0, 180]:[90,0,0]) mirror([0,end,0]) bed_mount();
	}
}
//x ends
translate([ 0, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 0, 0]) x_end();
translate([ x_travel + x_carriage_width + bearing_size + 6, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 0, 0]) {
	x_end(2);
	translate([-yz_motor_distance / 2, 8 + rod_size, 0]) rotate([90, 0, 0])
		translate([0, (x_rod_spacing + 8 + rod_size) / 2, rod_size / 2 - 2 - bearing_size / 2 - 4 - idler_pulley_width - 1.5]) idler_pulley(true);
}
//x axis
translate([40, rod_size + bearing_size / 2 + 1 - rod_size / 2 + 2, 60 + (2*x_rod_spacing + 16 + 2*rod_size) / 2]) {
	rotate([90, 0, 90]) x_carriage();
}
//y axis
translate([60, 0, -bearing_size - rod_size / 2 - bearing_size / 2]) {
	rotate([0, 90, 0]) y_idler();
	for(side = [1, -1]) translate([5, side * (motor_casing / 2 - rod_size / 2), idler_pulley_width + 1.5 + rod_size]) rotate([180, 0, 0]) idler_pulley(true);
}
translate([60 + 18,-(motor_casing + rod_size * 3 + 22 + y_travel) / 2 + 14,+5]) rotate([180,0,0]) belt_clamp();
//feet
for(side = [0, 1]) mirror([0, side, 0])
	translate([z_rod_offset, -motor_casing / 2 - rod_size * 2 - 10, -bearing_size - end_height + rod_size * 1.5]) rotate([90, 0, 0]) foot();
%translate([(x_travel + x_carriage_width) / 2 + bearing_size / 2 + 3, 0 , 5]) cube([x_travel - 10, y_travel - 10, 5], center =  true);
//bed
translate([(x_travel + x_carriage_width) / 2 + bearing_size / 2 + 3, 0, -8+bed_mount_height]) bed_plate();




