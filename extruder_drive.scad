include <config.scad>;

extruder_drive();

module extruder_drive() {
translate([-2,bearing_size/2+4,0]) difference() {
	union() {
		//motor boss
		translate([-bearing_size/2-4-8,21,0]) cube([21.25,x_rod_spacing / 2 +bearing_size / 2 -6,x_carriage_width/2+14]);
		translate([-bearing_size/2-4-8,14,0]) cube([21.25,x_rod_spacing / 2 +bearing_size / 2 -6,x_carriage_width]);
		difference(){
			translate([-bearing_size/2-4-8+1.125,x_rod_spacing / 2 +bearing_size / 2 + 28/2+1,x_carriage_width/2]) rotate([-45,0,0]) translate([9,7,-14]) cube([20.25,14,28],center=true);
			translate([-90,0,-20]) cube([100,100,20]);
		}
		translate([-bearing_size/2-4-8,x_rod_spacing / 2 +bearing_size / 2 + 28/2+1,x_carriage_width/2]) rotate([0,90,0]) rotate([0,0,-beta]) {
			cylinder(r=28/2,h=21.25);
			for(i=[1,-1]) translate([0,i*35/2,13.25]) cylinder(r=4,h=8);
			translate([0,0,17.25]) cube([8,35,8],center=true);
		}
		translate([-1,(x_rod_spacing+bearing_size)/2,0]) cube([4,15+35/2*cos(beta),8]);
		}
		//extruder drive
		translate([4,x_rod_spacing / 2 +bearing_size / 2 + 30/2,x_carriage_width/2]) rotate([0,90,0]) rotate([0,0,-beta]) union() {
			translate([0,0,1]) cylinder(r=30/2,h=19);
			for(i=[1,-1]) translate([0,i*35/2,-29]) union() {
			    cylinder(r=6.3/2,h=20);
		        cylinder(r=4.3/2,h=30);
		    }
			translate([0,-35/2,-29]) rotate([0,0,beta]) translate([-6,0,10]) cube([12,6.3,20],center=true);
			translate([-17.5,1.5,9.5]) cube([43,68,17],center=true);
			//idler
			rotate([0,0,-(90-beta)-alpha]) translate([r+1.75/2,0,-19.75]) union() {
			    translate([0,0,1]) cylinder(r=5.5,h=5);//idler 623 bearing (10,4,3)
			    rotate([0,0,-90+alpha]) translate([40,0,3.5]) cube([80,11,5],center=true);
			    rotate([0,0,30]) cylinder(r=3.3/sqrt(3),h=50,center=true,$fn=6);
			}
			//drive support bearing
			translate([8,0,-23]) {
			    cylinder(r=10.3/2,h=24);
		        rotate([0,0,beta-90]) translate([0,2,2.5]) {
				    translate([0,2,-2]) cylinder(r=10.3/2,h=4);
		            cube([10.3,4,4],center=true);
		            rotate([-90,0,0]) rotate([0,0,22.5]) cylinder(r=3.4/2,h=20,$fn=8);
		            translate([0,7,-2]) cube([5.8,4,4],center=true);
		            translate([0,5,0]) rotate([-90,0,0]) rotate([0,0,30]) cylinder(r=5.8/sqrt(3),h=4,$fn=6);
		        }         
		    }
		}
		//motor
		%translate([3,x_rod_spacing / 2 +bearing_size / 2 + 28/2+1,x_carriage_width/2]) rotate([0,90,0]) rotate([0,0,-beta]) {
		    cylinder(r=28/2,h=19);
		    translate([8,0,-11]) cylinder(r=5,h=10);
		    translate([8,0,-11-8]) cylinder(r=5.6/2,h=7);
		    for(i=[1,-1]) translate([0,i*35/2,0]) cylinder(r=4,h=1);
		    translate([0,0,0.5]) cube([8,35,1],center=true);
		}
		//filament path
		translate([-bearing_size/2-7-4+5,70,20]) rotate([90,0,0]) cylinder(r=2.3/2,h=100,$fn=12);
		//barrel holder
		translate([-bearing_size/2-7-4+5,x_rod_spacing/2-1.1,20]) rotate([-90,0,0]) {
			#translate([0,0,0]) polyhole(r=barrel_dia/2,h=6.2);
			for(i=[1,-1]) translate([2,i*(x_carriage_width/2 - 4),0]) {
			    polyhole(r=m3_size/2,h=15);
			    translate([0,0,5]) {
			        rotate([0,0,30]) cylinder(r=m3_nut_size/sqrt(3),h=3,$fn=6,center=true);
			        translate([0,i*10,0]) cube([m3_nut_size,20,3],center=true);
			    }
			}
		}
	}
	//hot end
//	%translate([0,-5,0]) union(){
	//translate([-8-bearing_size/2-7,-8-1.75,0]) cube([8,8,40]);
//	translate([-8-bearing_size/2-7,x_rod_spacing/2,0]) cube([11,4,40]);
	//translate([-20-bearing_size/2-7-8,-8-1.75,0]) cube([20,40,40]);
//	translate([-bearing_size/2-7-4,-9.75,20]) rotate([90,0,0]) cylinder(r=2,h=4);
//	translate([-8-bearing_size/2-7-8,-8-4-9.75,16]) cube([16,8,16]);
//	}
}

