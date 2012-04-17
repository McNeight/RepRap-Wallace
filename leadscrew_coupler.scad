include <config.scad>;

for(side = [-1,1]) {
	for(end=[-1,1]) {
		translate([end*length, side * motor_screw_spacing / 2, 0])
		leadscrew_coupler();
	}
}

bore=8;
height=8;
wall=3;
length=12;
hole_dist=7;

module leadscrew_coupler() difference(){
	union(){
		cylinder(h=height,r=(bore/2)+wall);
		translate([0,length/2,height/2]) cube([bore+2*wall,length,height],center=true);
	}
	translate([0,0,height/2]) cylinder(h=height*1.2, r=bore/2,center=true);
	translate([0,length/2,height/2]) cube([bore-3,length*1.2,height*1.2], center=true);
	translate([0,hole_dist,height/2]) rotate([0,90,0]) rotate([0,0,30]) cylinder(h=bore+2*wall+09.1,r=3.3/sqrt(3), center=true, $fn=6);
	translate([-bore/2-wall-0.01,hole_dist,height/2]) rotate([0,90,0]) cube([height*1.2,5.8,2],center=true);
}

