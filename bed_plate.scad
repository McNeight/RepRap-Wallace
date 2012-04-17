include <config.scad>;

projection(cut=true) bed_plate();

module bed_plate() {
	color([0.8,0.0,0.0,0.5,0.5])
		translate([0,0,2.5]) difference(){
		cube([x_travel + x_carriage_width + bearing_size + 6 - (yz_motor_distance / 2 + z_rod_offset + bearing_size / 2), motor_casing + rod_size * 3 + 22 + y_travel,5], center = true);
		for(k = [1,-1]) translate([k * (x_travel / 2 - 5 + 20),0,0]) cube([40,motor_casing + rod_size * 3 + 2 - 20 + y_travel,6], center = true);
		//bed mount holes
		for(ii=[1,-1]) {
			for(jj=[1,-1]) {
				translate([ii*((x_travel + x_carriage_width + bearing_size + 6 - (yz_motor_distance / 2 + z_rod_offset + bearing_size / 2))/2-5),jj*((motor_casing + rod_size * 3 + 22 + y_travel)/2-5),0]) cylinder(r=m3_size/2,h=5.2, center=true);
				translate([-38.5+ii*4.5,-jj*((motor_casing + rod_size * 3 + 22 + y_travel)/2-11),0]) cylinder(r=m3_size/2,h=5.2, center=true);
			}
		}
		//build surface mount holes
		for(i=[1,-1,0]) {
			translate([i*44/2,(i!=0) ? 148 / 2 : -148 / 2,0]) cylinder(r=m3_size/2,h=5.2, center=true);
		}
		translate([0,152/2,0]) cube([36,16,5.2], center=true);
	}
}

