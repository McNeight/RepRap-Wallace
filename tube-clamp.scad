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
clamp_offset=8;

//for(i=[0,1]) mirror([0,i,0]) translate([0,10,outer_r])
	barclamp();

module barclamp(){

difference(){
	union(){
		
		translate([0, 0, 0])cylinder(h =outer_r*2, r = outer_r, $fn = 60,center=true);
		translate([0, 0, 0]) {
			translate([(clamp_offset+rod_size/2+3)/2,0,0]) cube([clamp_offset+rod_size/2+3,outer_r*2,outer_r*2],center=true);
		}
	}


	//translate([(clamp_offset+rod_size), 0, 0]) cube([clamp_offset+rod_size+4,outer_r-1,20],center=true);
	translate([0, 0, 0]) cylinder(h =outer_r*2.1, r = 3/2, $fn = 18,center=true);
	translate([0, 0, outer_r]) cylinder(h =outer_r*2.1, r = 4.5/2, $fn = 18,center=true);
	translate([clamp_offset, 30, 0]) rotate([90, 0, 0]) rotate([0,0,22.5]) cylinder(h =40, r = rod_size/2, $fn = 8);
}
}
