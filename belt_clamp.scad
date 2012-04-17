include <config.scad>;

//belt clamps for printing
for(i=[0,1]) translate([0,i*-10,0]) mirror([0,i,0]) belt_clamp();

module belt_clamp() mirror([1,0,0]) {
	difference() {
		//body
		cube([20,14,12]);
		translate([0,-2,1]) rotate([45,0,0]) cube([20,20,10]);
		translate([2,-3,4]) cube([16,10,10]);
		//mounting nut/screw holes
		for(i=[1,-1]) translate([10 + i *4.5,3.5, 1]) {
			translate([0,0,-1]) cylinder(r=3.3/2,h=5, $fn=24);
			translate([0,0,1]) rotate([0,0,30]) cylinder(r=5.8/sqrt(3),h=2,$fn=6);
			translate([-5.8/2,-5,1]) cube([5.8,5,2]);
		}
		//belt clearance slot
		translate([2,5,5]) cube([2, 10, 6]);
		//belt clamp
		translate([16.2,5,5]) cube([1.8, 10, 8]);
		translate([17.9,12.8,5]) for(j=[0,1,2]) {
			translate([0,j*-2.5,0]) cube([0.7, 1.3, 8]);
		}
		//belt tension screw hole
		translate([10,5,8]) rotate([-90,0,0]) cylinder(r=3.3/2,h=10);
		translate([10,12,8]) rotate([-90,0,0]) cylinder(r=5.8/sqrt(3),h=2.2,$fn=6);
	}
}

