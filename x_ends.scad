include <config.scad>;

//x ends for printing
//translate([12,10,0]) rotate()
	x_end(0);
//translate([32,40,0]) rotate([0,0,-90])
//	x_end(1);

//x end module
this_h=x_rod_spacing + 8 + rod_size;

module x_end(motor = 0) mirror([(motor == 0) ? 0 : 1, 0, 0]) translate([-motor_casing / 4 - rod_size / 2,0,0]) difference() {
	union() {
		if(motor > 0) translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2 - motor_casing, 8 + rod_size, 0]) rotate([90, 0, 0]) {
			// Motor holder
			translate([0,0,-9.25]) difference() {
				cube([motor_casing + 18, x_rod_spacing + 8 + rod_size,6]);
				translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 2, 0]) {
					cylinder(r=motor_screw_spacing / 2,h=6);
					for(x = [1, -1]) for(y = [1, -1]) translate([x * motor_screw_spacing / 2, y * motor_screw_spacing / 2, 0]) {
						for(i=[0,3]) translate([i,0,0]) cylinder(r=m3_size /sqrt(3), h=6,$fn = 6);
						translate([1.5,0,3]) cube([3,m3_size,6.2],center=true);
						
					}
					translate([-(motor_casing * 1.5 - motor_screw_spacing), (motor > 1) ? (motor_casing / 2 - motor_screw_spacing) : 0, 0]) cube([motor_casing, x_rod_spacing + 8 + rod_size,6]);
				}
			}
			// Belt
			%translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 2, rod_size / 2 - 2 - bearing_size / 2 - 2 - idler_pulley_width / 2]) rotate([180, 0, 0]) difference() {
				union() {
					cylinder(r=pulley_size / 2 + 2,h=5);
					translate([0, -pulley_size / 2 - 2, 0]) cube([200.5, pulley_size + 4,5]);
					translate([200.5, 0, 0]) cylinder(r=pulley_size / 2 + 2,h=5);
				}
				cylinder(r=pulley_size / 2,h=5);
				translate([0, -pulley_size / 2, 0]) cube([200.5, pulley_size,5]);
				translate([200.5, 0, 0]) cylinder(r=pulley_size / 2,h=5);
			}

		}
		difference() {
			union() {
				//for(side = [1, -1]) translate([side * (motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 + 3, $fn = 30);
				translate([(motor_casing / 4 + rod_size / 2), 0, 0]) cylinder(r=bearing_size / 2 + 3, h=this_h, $fn = 30);
				translate([-(motor_casing / 4 + rod_size / 2), 0, 0]) cylinder(r=rod_nut_size / 2 + 3, h=this_h, $fn = 30);
				translate([0,0,this_h/2]) cube([motor_casing / 2 + rod_size, bearing_size / 2 + 3,this_h], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, bearing_size / 2, 0]) cube([(motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3) / 2, 12 + rod_size / 2,this_h]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, bearing_size / 2-1.4, 0]) cube([motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3, bearing_size / 2 + 3 + rod_size / 2,this_h]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, 0, 0]) cube([(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + 5 - rod_size / 2 - 2, 6 + rod_size,this_h]);
				//translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, bearing_size / 2 + rod_size / 2 + 4, 0]) cylinder(r=rod_size / 2 + 2,h=this_h);
				translate([0, bearing_size / 2 + rod_size + 6, this_h/2]) cube([10,10,this_h], center = true);
			}
			translate([rod_size/2,0,this_h/2]) cube([motor_casing / 2 + rod_size, 3,this_h*1.1], center = true);
			translate([(motor_casing / 4 + rod_size / 2), 0, 0]) cylinder(r=bearing_size / 2 - 0.5, h=this_h, $fn = 30);
			translate([-(motor_casing / 4 + rod_size / 2), 0, -0.1]) rotate(90) cylinder(r=rod_nut_size / 2, h=this_h*1.1, $fn = 6);
			translate([4 + rod_size / 2, bearing_size / 2 + rod_size / 2 + 3, 0]) {
				translate([0,0,this_h/2]) cube([motor_casing / 2 + rod_size + bearing_size + 8, rod_size / 2,this_h*1.1], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2, 0.5, -0.1]) cylinder(r=rod_size / 4 + 0.5, h=this_h*1.1, $fn = 12);
			}
		}
		if(motor > 0) translate([-20.9,18.6,0]) mirror([1,1,0]) linear_extrude(height=3, convexity=5) polygon([[0,0],[17.5,0],[0,38.9]]);
	}
	//drive nut and spring access
	//translate([-yz_motor_distance/2,-16,(x_rod_spacing + 8 + rod_size)/2]) rotate([0,90,0]) {
	    //rotate([0,0,45/2]) cylinder(r=16,h=2*(rod_nut_size/sqrt(3)),$fn=8,center=true);
	    //translate([0,16*sin(45/2)+rod_size/2+0.5,0]) cube([16+rod_size/2,2*16*sin(45/2),2*(rod_nut_size/sqrt(3))],center=true);
	//}
	translate([0, 0, (x_rod_spacing + rod_size + 8) / 2]){
		for(end = [0, 1]) mirror([0, 0, end]) translate([motor_casing / 4 + rod_size / 2, 0, -(x_rod_spacing + rod_size + 8) / 2 - 1]) cylinder(r = bearing_size / 2 + 0.05, h = bearing_length, $fn = 30);
		for(side = [1, -1]) render(convexity = 5) translate([0, bearing_size / 2 + rod_size / 2 + 3, side * x_rod_spacing / 2]) rotate([0, 90, 0]) {
			//cylinder(r = rod_size / 2, h = motor_casing / 2 + rod_size + bearing_size + 10, center = true, $fn = 30);
			difference() {
				translate([0, 0, (motor > -1) ? rod_size / 2 + 2 : 0]) intersection() {
					rotate(45) cube([rod_size + 2, rod_size + 2, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
					cube([rod_size * 2, rod_size + 2, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
				}
				translate([0, rod_size, 0]) cube([rod_size * 2, rod_size * 2, 6], center = true);
				for(end = [1, -1]) translate([0, -rod_size, end * (motor_casing / 4 + rod_size / 2)]) cube([rod_size * 2, rod_size * 2, 6], center = true);
			}
			translate([0, 0, rod_size / 2 + 2]) intersection() {
				rotate(45) cube([rod_size, rod_size, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
				cube([rod_size * 2, rod_size + 1, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
			}
		}
		// holes for clamping screws
		rotate([90, 0, 0]) {
			cylinder(r = m3_size * da6, h = 100, center = true, $fn = 6);
			translate([0, 0, bearing_size / 4 + .5]) cylinder(r = m3_nut_size / sqrt(3), h = 100, center = false, $fn = 6);
		}
		//holes for endstop
		for(side=[1,-1]) translate([yz_motor_distance / 2, bearing_size / 2 + 1, side * 9.5 / 2]) rotate([-90,0,0]) cylinder(r=2.8/2,h=10);
	}
	//z nut bores
	translate([-(motor_casing / 4 + rod_size / 2), 0, -0.1]) rotate(0) cylinder(r = rod_nut_size / sqrt(3), h = x_rod_spacing - 10 + rod_size, $fn = 6);
	translate([0,0,(x_rod_spacing + 8 + rod_size)/2]) for(i=[1,0]) mirror([0,0,i]) translate([motor_casing / 4 + rod_size / 2-bearing_size/2-2,0,(x_rod_spacing + 8 + rod_size)/2]) rotate([0,-30,0]) translate([-(motor_casing / 2 + rod_size)/2,-5,bearing_size]) cube([motor_casing + rod_size,2*rod_nut_size/sqrt(3)+10,bearing_size*2],center=true);
	//translate([-(motor_casing / 4 + rod_size / 2), 0, 0]) rotate(90) cylinder(r = rod_nut_size / sqrt(3), h =5, $fn = 6);
	translate([(motor_casing / 4 + rod_size / 2), 0, 5]) %rotate(180 / 8) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
}


