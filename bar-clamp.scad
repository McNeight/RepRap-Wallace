// PRUSA Mendel  
// Bar clamp
// Used for joining 8mm rods
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <config.scad>

outer_r = rod_size/2+3.3;
clamp_offset=18;
clamp_width=outer_r*2+13.7;

for(i=[0,1]) mirror([0,i,0]) translate([0,10,outer_r])
	barclamp();

module barclamp(){

difference(){
	union(){
		
		translate([0, 0, 0])cylinder(h =outer_r*2, r = outer_r, $fn = 60,center=true);
		translate([0, 0, 0]) {
			translate([(clamp_offset+rod_size/2+3)/2,0,0]) cube([clamp_offset+rod_size/2+3,outer_r*2,outer_r*2],center=true);
			translate([clamp_offset+3+rod_size/2-(rod_size+6)/2,clamp_width/2-outer_r,0]) cube([rod_size+6,clamp_width,outer_r*2],center=true);
		}
		//translate([0,0,0])
			rotate([0,0,-47])
				translate([0,outer_r*3.5/2,0]) cube([outer_r*2,outer_r*3.5,outer_r*2],center=true);
	}


	translate([(clamp_offset+rod_size+4)/2, 0, 0]) cube([clamp_offset+rod_size+4,outer_r-1,20],center=true);
	translate([0, 0, 0]) cylinder(h =outer_r*2.1, r = rod_size/2, $fn = 18,center=true);
	translate([clamp_offset, 30, 0]) rotate([90, 0, 0]) rotate([0,0,22.5]) cylinder(h =40, r = rod_size/2, $fn = 8);
}
}
