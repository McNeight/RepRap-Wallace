rod_size = 6.3;
z_rod_size = 5.3;
rod_nut_size = 8.4; //8.3 for M5, 12 for M6, 15 for M8
bearing_size = 12.5; //12.5 for LM6UU, 15.5 for LM8UU,LM8SUU
bearing_length = 19.5; //19.5 for LM6UU, 17.5 for LM8SUU, 24.5 for LM8UU
yz_motor_distance = 25;
motor_screw_spacing = 26; //26 for NEMA14, 31 for NEMA17
motor_casing = 38; //38 for NEMA14, 45 for NEMA17
end_height = 40; //measure the height of your motor casing and add 4mm. Suggestion: 40 for NEMA14, 55 for NEMA17
bed_mount_height = 13;
//x_rod_spacing = motor_screw_spacing + 3 + rod_size;
x_rod_spacing = 30;
x_carriage_width = 40;
carriage_extruder_offset = 5;
pulley_size = 10;
idler_pulley_width = 4;
gusset_size = 15;
m3_size = 3.3;
m3_nut_size = 6;
m4_size = 4.3;
motor_shaft_size = 5.3;
y_travel=150;
x_travel=150;
z_rod_offset = yz_motor_distance / 2 - rod_size;

echo("y smooth rod length = ",(motor_casing + rod_size * 3 + 2 + y_travel + 20));
echo("x smooth rod length = ", (x_travel+x_carriage_width+80-5));
echo("M6 base bars = ", 200);

// ratio for converting diameter to apothem
da6 = 0.5;//1 / cos(180 / 6) / 2;
da8 = 0.5412;//1 / cos(180 / 8) / 2;

//Comment out all of the lines in the following section to render the assembled machine. Uncomment one of them to export that part for printing. You can also use the individual files to export each part.

comp=7;

//base_ends
if(comp==1)!base_end(single=1);

//y_bearing_retainer
if(comp==2) translate([bearing_size / 4, bearing_size - (bearing_size * 2/3), 0]) rotate(180) y_bearing_retainer();

// y_bearing_retainer_slim
if(comp==3)!for(a = [0,1]) translate([bearing_size / 4, a * bearing_size, 5])  mirror([0,a,0]) y_bearing_retainer_slim();

//bed_mount
if(comp==4)!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -7.5, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();

//x_end
if(comp==5)!x_end(2);

//x_end
if(comp==6)!x_end();

//x_carriage
if(comp==7)!x_carriage();

//leadscrew_coupler
if(comp==8)!for(side = [-1,1]) translate([0, side * motor_screw_spacing / 2, 0]) leadscrew_coupler();

//y_idler
if(comp==9)!y_idler();

//idler_pulley
if(comp==10)!for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + 3), y * (pulley_size / 2 + 3), 0]) idler_pulley(true);

//foot
if(comp==11)!for(x = [1, -1]) translate([x * (rod_size * 2.5 + 2), rod_size * 1.5 + 2, 0]) foot();

//z_top_clamp
if(comp==12)!for(side = [0, 1]) mirror([side, 0, 0]) translate([-rod_size * 2.5, 0, 0]) z_top_clamp();

//bed_plate
if(comp==13)projection(cut=true) bed_plate();

//belt_clamp
if(comp==14)!for(end=[1,0]) mirror([0,end,0]) translate([0,end*4,0]) mirror([1,0,0]) belt_clamp();

//layout for printing
if(comp==97){
%cube([130,130,0.1], center=true);
translate([20,-30,0]) base_end(0);
translate([-32,-30,0]) base_end(1);
translate([12,10,0]) rotate() x_end(0);
translate([32,40,0]) rotate([0,0,-90]) x_end(1);
translate([25,56,0]) rotate([0,0,0]) y_bearing_retainer();
translate([-58,26,5]) rotate([0,0,90]) y_bearing_retainer_slim();
translate([-35,57,5]) rotate([0,0,180]) mirror([0,1,0]) y_bearing_retainer_slim();
translate([55,-30,0]) rotate() y_idler();
translate([-17,38,0]) rotate([0,0,0]) belt_clamp();
translate([-25,10,0]) rotate([0,0,0]) mirror([1,0,0]) belt_clamp();
translate([-48,38,0]) rotate([0,0,90]) bed_mount();
translate([-32,33,0]) rotate([0,0,90]) bed_mount();
translate([13,32,0]) rotate([0,0,90]) bed_mount();
translate([53,42,0]) rotate([0,0,90]) bed_mount();
translate([46,-50,rod_size/2 + 4]) rotate([-90,0,90]) foot();
translate([-42,2,rod_size / 2 + 4]) rotate([-90,0,0]) foot();

}
if(comp==98){
x_end(2);
translate([10,-20,0]) rotate([0,0,180]) x_end(0);

}

//The following section positions parts for rendering the assembled machine.
if(comp==99){
	translate([0, 0, -bearing_size]) rotate([0, 180, 0]) base_end(0);
	translate([x_travel + x_carriage_width + bearing_size + 6, 0, -bearing_size]) rotate([0, 180,180]) base_end(1);
	for(end = [1, -1]) translate([z_rod_offset, end * -(motor_screw_spacing / 2 + 5), -bearing_size + bearing_size * sqrt(2) / 4]) mirror([0, (end == 1) ? 1 : 0, 0]) rotate([-90, 0, 180]) y_bearing_retainer_slim();
	translate([x_travel + x_carriage_width + 6 + 3 * rod_size - yz_motor_distance / 2, -(motor_screw_spacing / 2 + 5), -bearing_size + bearing_size * sqrt(2) / 4]) rotate([-90, 0, 0]) y_bearing_retainer();
	for(end=[0, 1]) {
		for(side = [0, 1]) translate([end * (x_travel + x_carriage_width + bearing_size + 6 - (yz_motor_distance / 2 + z_rod_offset + bearing_size / 2)), 0, 0]) mirror([0, side, 0]) {
			translate([yz_motor_distance / 2 - bearing_size / 2 + z_rod_offset, -(motor_casing + rod_size * 3 + 2) / 2 - y_travel / 2, -bearing_size + bearing_size * sqrt(2) / 4])
				rotate(end==1?[-90, 0, 180]:[90,0,0]) mirror([0,end,0]) bed_mount();
		}
	}
	translate([ 0, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 180, 0]) x_end(2);
	translate([ x_travel + x_carriage_width + bearing_size + 6, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 180, 0]) {
		x_end(0);
		translate([-yz_motor_distance / 2, 8 + rod_size, 0]) rotate([90, 0, 0]) translate([0, (x_rod_spacing + 8 + rod_size) / 2, rod_size / 2 - 2 - bearing_size / 2 - 4 - idler_pulley_width - 1.5]) idler_pulley(true);
	}
translate([40, rod_size + bearing_size / 2 + 1 - rod_size / 2 + 2, 60]) {
		rotate([90, 0, 90]) x_carriage();
		//translate([x_carriage_width / 2 + carriage_extruder_offset, -14 - bearing_size / 2 - 4, x_rod_spacing / 2 + bearing_size / 2 + 4]) {
			//rotate([90, 0, 180]) translate([10.57, 30.3, -14]) import("gregs/gregs_accessible_wade-wildseyed_mount.stl", convexity = 5);
			//%rotate(180 / 8) cylinder(r = 2, h = 150, center = true, $fn = 8);
		//}
	}
	translate([-yz_motor_distance / 2 - motor_casing / 2, 0, -bearing_size / 2]) leadscrew_coupler();
	translate([60, 0, -bearing_size - rod_size / 2 - bearing_size / 2]) {
		rotate([0, 90, 0]) y_idler();
		for(side = [1, -1]) translate([5, side * (motor_casing / 2 - rod_size / 2), idler_pulley_width + 1.5 + rod_size]) rotate([180, 0, 0]) idler_pulley(true);
	}
	for(side = [0, 1]) mirror([0, side, 0]) translate([z_rod_offset, -motor_casing / 2 - rod_size * 2 - 10, -bearing_size - end_height + rod_size * 1.5]) rotate([90, 0, 0]) foot();
	translate([-yz_motor_distance / 2 + rod_size, 0, 210 - end_height]) rotate([180, 0, 90]) z_top_clamp(0);
	%translate([(x_travel + x_carriage_width) / 2 + bearing_size / 2 + 3, 0 , 5]) cube([x_travel - 10, y_travel - 10, 5], center =  true);
	translate([(x_travel + x_carriage_width) / 2 + bearing_size / 2 + 3, 0, -8+bed_mount_height]) bed_plate();
	translate([60 + 18,-(motor_casing + rod_size * 3 + 22 + y_travel) / 2 + 14,-1]) rotate([180,0,0]) mirror([1,0,0]) belt_clamp();
}

module belt_clamp() {
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
module z_top_clamp() difference() {
	union() {
		linear_extrude(height = rod_size * 2 + gusset_size, convexity = 5) difference() {
			union() {
				circle(r = rod_size * da6 * 2, $fn = 6);
				translate([0, -rod_size, 0]) square([rod_size * (1 + da6), rod_size * 2]);
				translate([rod_size - rod_size * da6, rod_size / 2, rod_size]) square([rod_size * da6 * 2, rod_size / 2 + gusset_size]);
			}
		}
		translate([rod_size, -rod_size - 1, rod_size]) rotate([-90, 0, 0]) cylinder(r = rod_size / cos(180 / 6), h = rod_size * 2 + gusset_size + 2, $fn = 6);
	}
	translate([rod_size, -rod_size - 2, rod_size]) rotate([-90, 0, 0]) cylinder(r = rod_size * da6, h = gusset_size + rod_size * 2 + 4, $fn = 6);
	translate([rod_size, rod_size + gusset_size, rod_size * 2 + gusset_size]) rotate([45, 0, 0]) cube([rod_size * 2, gusset_size * sqrt(2), gusset_size * sqrt(2)], center = true);
	translate([0, 0, -1]) linear_extrude(height = rod_size * 2 + gusset_size + 2, convexity = 5) {
		circle(r = rod_size * da6, $fn = 6);
		%translate([rod_size, -10, rod_size * da6 * 2]) rotate([-90, 0, 0]) cylinder(r = rod_size * da6, h = 160, $fn = 6);
		translate([0, -rod_size / 2, 0]) square([gusset_size + rod_size * 2 + 1, rod_size]);
	}
}

module foot() difference() {
	linear_extrude(height = rod_size, convexity = 5) difference() {
		//minkowski() {
		//	square(rod_size + 2, center = true);
		//	circle(rod_size, $fn = 16);
		//}
		translate([1,0,0]) circle(r = 2 * rod_size);
		circle(rod_size / 2, $fn = 12);
	}
	translate([0, 0, -rod_size / 16]) cylinder(r1 = rod_size * 3/4, r2 = rod_size / 4, h = rod_size / 2, $fn = 12);
	translate([0, 0, rod_size / 2 + rod_size / 16]) cylinder(r2 = rod_size * 3/4, r1 = rod_size / 4, h = rod_size / 2, $fn = 12);
	#translate([-2 * rod_size,rod_size / 2 + 4,0]) cube([4*rod_size,2 * rod_size,rod_size]);
}

module idler_pulley(double_bearing = true) difference() {
	cylinder(r=pulley_size / 2,h=idler_pulley_width);
}

module y_idler() difference() {
	union() {
		translate([-2-rod_size+3,0,10]) cube([4,motor_casing+0.7,20], center=true);
    	linear_extrude(height = 10, convexity = 5) difference() {
    		union() {
    			square([rod_size * 2, motor_casing + rod_size * 2], center = true);
    			for(side = [1, -1]) {
    				translate([0, side * (motor_casing / 2 + 5), rod_size / 2 + bearing_size / 2]) rotate(180 / 8) circle(rod_size * 13/12, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
    				translate([-rod_size-3,side * (motor_casing / 2 - rod_size / 2)]) square([6,7],center=true);
    			}
    		}
    		for(side = [1, -1]) translate([0, side * (motor_casing / 2 + 5), rod_size / 2 + bearing_size / 2]) {
    			rotate(180 / 8) circle(rod_size * da8, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
    			translate([rod_size,0]) square([rod_size*2,rod_size], center=true);
    		}
    	}
	}
	#translate([0,0,10+motor_casing/2]) rotate([0,90,0]) cylinder(r=12,h=50,center=true);

	for(i=[1,-1]) translate([0,i*motor_screw_spacing/2,14.5]) rotate([0,90,0]) rotate([0,0,22.5]) cylinder(r = m3_size * da8, h = rod_size * 4, center = true, $fn = 8);

	rotate([90, 0, 90]) {
		for(side = [1, -1]) translate([side * (motor_casing / 2 - rod_size / 2), 5, -3]) {
			rotate([0,0,22.5]) cylinder(r = m3_size * da8, h = rod_size * 4, center = true, $fn = 8);
			translate([0, 0, rod_size]) cylinder(r = m3_nut_size / sqrt(3), h = 4, $fn = 6);
		}
		//belt
		%translate([0, 5, -6-rod_size - idler_pulley_width / 2]) linear_extrude(height = 5, center = true, convexity = 5) for(side = [1, 0]) mirror([side, 0, 0]) {
			translate([-(motor_casing / 2 - rod_size / 2), 0, 0]) {
				intersection() {
					difference() {
						circle(pulley_size / 2 + 2);
						circle(pulley_size / 2);
					}
					square(pulley_size);
				}
				rotate(90) difference() {
					translate([2, 0, 0]) square([pulley_size / 2, 40]);
					square([pulley_size / 2, 40]);
				}
				rotate(-90) difference() {
					translate([0, 2, 0]) square([60 - yz_motor_distance / 2 - motor_screw_spacing / 2, pulley_size / 2]);
					square([60, pulley_size / 2]);
				}
			}
			translate([0, -(60 - yz_motor_distance / 2 - motor_screw_spacing / 2), 0]) difference() {
				circle(motor_casing / 2 - rod_size / 2 - pulley_size / 2);
				circle(motor_casing / 2 - rod_size / 2 - pulley_size / 2 - 2);
				translate([-(motor_casing / 2 - rod_size / 2 - pulley_size / 2), 0, 0]) square(motor_casing - rod_size - pulley_size);
			}
		}
	}
}

module leadscrew_coupler() difference() {
	linear_extrude(height = 10 + rod_nut_size / 2 + 1, convexity = 5) difference() {
		circle(motor_screw_spacing / 2 - 1);
		circle(motor_shaft_size * da6, $fn = 6);
	}
	translate([0, 0, m3_nut_size / 2]) rotate([-90, 0, 90]) {
		cylinder(r = m3_size * da6, h = motor_screw_spacing / 2 + 1);
		%rotate(90) cylinder(r = m3_nut_size / 2, h = 5.5, $fn = 6);
		translate([0, 0, 12]) cylinder(r = m3_size * da6 * 2, h = motor_screw_spacing / 2);
		translate([-m3_nut_size / da6 / 4, -m3_nut_size / 2, 0]) cube([m3_nut_size / da6 / 2, m3_nut_size + 1, 5.7]);
	}
	translate([0, 0, 10]) cylinder(r = rod_nut_size / sqrt(3), h = rod_nut_size + 1, $fn = 6);
	//translate([0, 0, -1]) cube(100);
}
carriage_top=x_rod_spacing / 2 +bearing_size / 2 -8;
module x_carriage() {
difference() {
union() {
	intersection() {
		linear_extrude(height = x_carriage_width, convexity = 5) difference() {
			union() {
				square([bearing_size + 8, x_rod_spacing], center = true);
				translate([0, -x_rod_spacing / 2 - bearing_size / 2 + 8 + pulley_size / 2+4.5, 0]) square([bearing_size / 2 + 4 + 15, x_rod_spacing / 2 + bearing_size / 2 + 0 - 12]);
				translate([0, pulley_size / 2+2.5, 0]) {
					square([bearing_size / 2 + 4 + 15, 8]);
					translate([bearing_size / 2 + 4 + 15, 4, 0]) circle(4);
				}
				rotate(180) translate([-bearing_size / 2 - 4, -x_rod_spacing / 2 - bearing_size / 2 - carriage_top+5, 0]) square([bearing_size + 8 + 11, bearing_size / 2 + 4 + carriage_top-8]);
				for(side = [1, -1]) translate([0, side * x_rod_spacing / 2, 0]) circle(bearing_size / 2 + 4, $fn = 30);
			}
			translate([bearing_size / 2 + 4, 2 + pulley_size / 2+2.5, 0]) {
				square([15, 4]);
				translate([0, -3, 0]) square([2, 4]);
				translate([15, 2, 0]) circle(2);
			}
			for(side=[1,-1]) translate([0, side * x_rod_spacing / 2, 0]) circle(bearing_size / 2, $fn = 6);
			translate([0, -x_rod_spacing / 2, 0]) rotate(90 * 0) square([2, bearing_size / 2 + 20]);
		}
		difference() {
			rotate([0, -90, 0]) linear_extrude(height = bearing_size + 100, convexity = 5, center = true) difference() {
				polygon([
					[
						0,
						(x_rod_spacing / 2 + bearing_size / 2 + carriage_top+3)
					],[
						0,
						-(x_rod_spacing / 2 + bearing_size / 2 + 4)
					],[
						bearing_length + 4,
						-(x_rod_spacing / 2 + bearing_size / 2 + 4)
					],[
						bearing_length + 4,
						-(x_rod_spacing / 2 - bearing_size / 2 - 4)
					],[
						x_carriage_width,
						(x_rod_spacing / 2 - bearing_size / 2 - 4)
					],[
						x_carriage_width,
						(x_rod_spacing / 2 + bearing_size / 2 + carriage_top+3)
					]
				]);
			}
			translate([bearing_size / 2 + 4, -50, bearing_length - 5]) cube(100);
			
		}
	}
	//motor boss
	translate([-21.25,21,0]) cube([18,x_rod_spacing / 2 +bearing_size / 2 -6,x_carriage_width/2+14]);
	difference(){
	    translate([-20.125,x_rod_spacing / 2 +bearing_size / 2 + 28/2+1,x_carriage_width/2]) rotate([-45,0,0]) translate([9,7,-14]) cube([20.25,14,28],center=true);
	    translate([-90,0,-20]) cube([100,100,20]);
	}
	translate([-21.25,x_rod_spacing / 2 +bearing_size / 2 + 28/2+1,x_carriage_width/2]) rotate([0,90,0]) rotate([0,0,-beta]) {
	    cylinder(r=28/2,h=22.25);
	    for(i=[1,-1]) translate([0,i*35/2,18.25]) cylinder(r=4,h=4);
	    translate([0,0,20.25]) cube([8,35,4],center=true);
	}
    translate([-3,(x_rod_spacing+bearing_size)/2,0]) cube([4,15+35/2*cos(beta),8]);
	}
	// linear bearings
	translate([0, x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
		%translate([0, 0, 20]) rotate(180 / 8) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
		for(end = [0, 1]) mirror([0, 0, end]) translate([0, 0, end * -x_carriage_width - 1]) cylinder(r = bearing_size / 2, h = bearing_length, $fn = 30);
	}
	translate([0, -x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
		translate([0, 0, 4]) cylinder(r = bearing_size / 2, h = x_carriage_width + 1, center = false, $fn = 30);
		%translate([0, 0,20]) rotate(180 / 8) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
	}
	// screw holes
	translate([bearing_size / 2 + 4 + 10, 5 - pulley_size + 11, bearing_length / 2 - 2]) rotate([90, 0, 0]) {
		cylinder(r = m3_size * da6, h = x_rod_spacing + bearing_size + 10, center = true, $fn = 6);
		rotate([180, 0, 0]) cylinder(r = m3_size * da6 * 2, h = x_rod_spacing + bearing_size + 10, center = false, $fn = 6);
		translate([0, 0, x_rod_spacing / 2 + bearing_size / 2 + 6 - 2*pulley_size]) cylinder(r = m3_nut_size * da6, h = x_rod_spacing + bearing_size + 10, center = false, $fn = 6);
	}
	#translate([0,0,x_carriage_width/2]) rotate([0,90,0]) {
		cylinder(r = m3_size * da6, h = x_rod_spacing + bearing_size + 60, center = true, $fn = 6);
		translate([0,0,-bearing_size / 2]) rotate([180, 0, 0]) cylinder(r = m3_size * da6 * 2, h = bearing_size, center = false, $fn = 6);
    }

	//extruder drive
	translate([-1,x_rod_spacing / 2 +bearing_size / 2 + 30/2+1,x_carriage_width/2]) rotate([0,90,0]) rotate([0,0,-beta]) union() {
	    cylinder(r=30/2,h=19);
	    translate([8,0,-19]) cylinder(r=5.5,h=19);
	    for(i=[1,-1]) translate([0,i*35/2,-22]) union() {
	        cylinder(r=6.3/2,h=20);
            cylinder(r=4.3/2,h=30);
        }
	    translate([0,-35/2,-22]) rotate([0,0,beta]) translate([-6,0,10]) cube([12,6.3,20],center=true);
	    translate([-17.5,1.5,9.5]) cube([43,68,19],center=true);
	    rotate([0,0,-(90-beta)-alpha]) translate([r+1.75/2,0,-18.5]) union() {
	        cylinder(r=5.5,h=5);//idler 623 bearing (10,4,3)
	        rotate([0,0,-90+alpha]) translate([40,0,2.5]) cube([80,11,5],center=true);
	        cylinder(r=3.3/2,h=50,center=true,$fn=12);
       	    //#translate([0,-35/2,-24]) rotate([0,0,90+alpha]) translate([r+1.75/2,0,20.5]) cube([12,6.3,20],center=true);
	    }
	    
	    echo("n",sqrt(nn));
	    echo("alpha",alpha);
	    echo("beta",beta);
	    echo("r",r);
    }
	//motor
	%translate([-1,x_rod_spacing / 2 +bearing_size / 2 + 28/2+1,x_carriage_width/2]) rotate([0,90,0]) rotate([0,0,-beta]) {
	    cylinder(r=28/2,h=19);
	    translate([8,0,-11]) cylinder(r=5,h=10);
	    translate([8,0,-11-8]) cylinder(r=5.6/2,h=8);
	    for(i=[1,-1]) translate([0,i*35/2,0]) cylinder(r=4,h=1);
	    translate([0,0,0.5]) cube([8,35,1],center=true);
	}
	translate([-bearing_size/2-7-4,70,20]) rotate([90,0,0]) cylinder(r=2.3/2,h=100,$fn=12);//filament
}
	//hot end
	%translate([0,-5,0]) union(){
	translate([-8-bearing_size/2-7,-8-1.75,0]) cube([8,8,40]);
	translate([-20-bearing_size/2-7-8,-8-1.75,0]) cube([20,40,40]);
	translate([-bearing_size/2-7-4,-9.75,20]) rotate([90,0,0]) cylinder(r=2,h=4);
	translate([-8-bearing_size/2-7-8,-8-4-9.75,16]) cube([16,8,16]);
	}
}
nn=64-pow(2.2+1.75/2,2);
r=sqrt(25+nn);
alpha=atan(5/sqrt(nn));
beta=acos((2.2+1.75/2)/8);

module x_end(motor = 0) mirror([(motor == 0) ? 0 : 1, 0, 0]) translate([-motor_casing / 4 - rod_size / 2,0,0]) difference() {
	union() {
		if(motor > 0) translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2 - motor_casing, 8 + rod_size, 0]) rotate([90, 0, 0]) {
			// Motor holder
			linear_extrude(height = 7) difference() {
				square([motor_casing + 3, x_rod_spacing + 8 + rod_size]);
				translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 2, 0]) {
					circle(motor_screw_spacing / 2);
					for(x = [1, -1]) for(y = [1, -1]) translate([x * motor_screw_spacing / 2, y * motor_screw_spacing / 2, 0]) circle(m3_size * da6, $fn = 6);
					translate([-(motor_casing * 1.5 - motor_screw_spacing), (motor > 1) ? (motor_casing / 2 - motor_screw_spacing) : 0, 0]) square([motor_casing, x_rod_spacing + 8 + rod_size]);
				}
			}
			// Belt
			%translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 2, rod_size / 2 - 2 - bearing_size / 2 - 2 - idler_pulley_width / 2]) rotate([180, 0, 0]) linear_extrude(height = 5, convexity = 5) difference() {
				union() {
					circle(pulley_size / 2 + 2);
					translate([0, -pulley_size / 2 - 2, 0]) square([200.5, pulley_size + 4]);
					translate([200.5, 0, 0]) circle(pulley_size / 2 + 2);
				}
				circle(pulley_size / 2);
				translate([0, -pulley_size / 2, 0]) square([200.5, pulley_size]);
				translate([200.5, 0, 0]) circle(pulley_size / 2);
			}

		}
		linear_extrude(height = x_rod_spacing + 8 + rod_size, convexity = 5) difference() {
			union() {
				//for(side = [1, -1]) translate([side * (motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 + 3, $fn = 30);
				translate([(motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 + 3, $fn = 30);
				translate([-(motor_casing / 4 + rod_size / 2), 0, 0]) circle(rod_nut_size / 2 + 3, $fn = 30);
				square([motor_casing / 2 + rod_size, bearing_size / 2 + 3], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, 0, 0]) square([(motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3) / 2, bearing_size / 2 + 4 + rod_size / 2]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, 0, 0]) square([motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3, bearing_size / 2 + 3 + rod_size / 2]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, 0, 0]) square([(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + 5 - rod_size / 2 - 2, bearing_size / 2 + 6 + rod_size]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, bearing_size / 2 + rod_size / 2 + 4, 0]) circle(rod_size / 2 + 2);
				translate([0, bearing_size / 2 + rod_size + 6, 0]) square(10, center = true);
			}
			translate([rod_size/2,0,0]) square([motor_casing / 2, 3], center = true);
			translate([(motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 - 0.5, $fn = 30);
			translate([-(motor_casing / 4 + rod_size / 2), 0, 0]) rotate(90) circle(rod_nut_size / 2, $fn = 6);
			translate([4 + rod_size / 2, bearing_size / 2 + rod_size / 2 + 3, 0]) {
				square([motor_casing / 2 + rod_size + bearing_size + 8, rod_size / 2], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2, 0.5, 0]) circle(rod_size / 4 + 0.5, $fn = 12);
			}
		}
	}
	//drive nut and spring access
	translate([-yz_motor_distance/2,-16,(x_rod_spacing + 8 + rod_size)/2]) rotate([0,90,0]) {
	    rotate([0,0,45/2]) cylinder(r=16,h=2*(rod_nut_size/sqrt(3)),$fn=8,center=true);
	    translate([0,16*sin(45/2)+rod_size/2+0.5,0]) cube([16+rod_size/2,2*16*sin(45/2),2*(rod_nut_size/sqrt(3))],center=true);
	}
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
	translate([-(motor_casing / 4 + rod_size / 2), 0, 8]) rotate(0) cylinder(r = rod_nut_size / sqrt(3), h = x_rod_spacing - 10 + rod_size, $fn = 6);
	//translate([-(motor_casing / 4 + rod_size / 2), 0, 0]) rotate(90) cylinder(r = rod_nut_size / sqrt(3), h =5, $fn = 6);
	translate([(motor_casing / 4 + rod_size / 2), 0, 5]) %rotate(180 / 8) cylinder(r = rod_size * da8, h = 200, center = true, $fn = 8);
}

module bed_mount() difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			rotate(180 / 8) circle((rod_size + 8) * da8, $fn = 8);
			translate([0, -rod_size / 2 - 4, 0]) square([rod_size / 2 + 8, max(rod_size + 8, rod_size / 2 + 4 + bed_mount_height)]);
		}
		rotate(180 / 8) circle(rod_size * da8, $fn = 8);
		translate([0, -rod_size / (1 + sqrt(2)) / 2, 0]) square([rod_size + 10, rod_size / (1 + sqrt(2))]);
	}
	translate([rod_size / 2 + 1.5, -rod_size / 2 - 6, 5]) rotate([-90, 0, 0]) {
		cylinder(r = m3_size/2, h = max(rod_size + 12, rod_size / 2 + 7 + bed_mount_height), $fn = 12);
		cylinder(r = m3_nut_size / sqrt(3), h = 4, $fn = 6);
	}
}

module y_bearing_retainer() difference() {
	intersection() {
	difference() {
		linear_extrude(height = motor_screw_spacing + 10, convexity = 5) difference() {
			union() {
				intersection() {
					translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2 + 4);
					translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, -bearing_size, 0]) square([bearing_size + 8, bearing_size]);
				}
				translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, 0, 0]) square([bearing_size + 8, bearing_size * sqrt(2) / 4 - 1]);
				translate([0, bearing_size * sqrt(2) / 4 - 3, 0]) square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, 4], center = true);
			}
			translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2);
			translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2, 0, 0]) square(bearing_size);
		}
		for(rh=[1,0]) for(side = [1, -1]) translate([side * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2,0, rh*motor_screw_spacing + 5]) rotate(90) rotate([90, 0, 90]) {
			cylinder(r = 3 * 7/12, h = bearing_size, center = true, $fn = 6);
			translate([0, 0, bearing_size * sqrt(2) / 4 - 5]) rotate([180, 0, 0]) cylinder(r = 3, h = bearing_size, $fn = 30);
		}
	}
	for(sides=[1,0]) translate([0, 0,sides* (motor_screw_spacing) + 5]) rotate(90) rotate([90, 0, 90]) cylinder(r = (yz_motor_distance + motor_casing - motor_screw_spacing + 10) / 2, h = bearing_size + 10, center = true, $fn = 6);
}
	translate([6,5,motor_screw_spacing/2+5]) rotate([90]) cylinder(h=20,r=4);
	rotate([30, 0, 0])  translate([-(bearing_size + 10) / 2 - bearing_size / 2, -10.5, 0]) cube([bearing_size + 10, 10, motor_screw_spacing / 2 + 7]);
	translate([0, 0, motor_screw_spacing + 10]) mirror([0, 0, 1]) rotate([30, 0, 0])  translate([-(bearing_size + 10) / 2 - bearing_size / 2, -10.5, 0]) cube([bearing_size + 10, 10, motor_screw_spacing / 2 + 7]);
}

module y_bearing_retainer_slim() intersection() {
	difference() {
		translate([0,0,-5]) linear_extrude(height = 15, convexity = 5) difference() {
			union() {
				intersection() {
					translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2 + 4);
					translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, -bearing_size, 0]) square([bearing_size + 8, bearing_size]);
				}
				translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, 0, 0]) square([bearing_size + 8, bearing_size * sqrt(2) / 4 - 1]);
				translate([0, bearing_size * sqrt(2) / 4 - 3, 0]) square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, 4], center = true);
			}
			translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2);
			translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2, 0, 0]) square(bearing_size);
		}
		for(side = [1, -1]) translate([side * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2,0,  5]) rotate(90) rotate([90, 0, 90]) {
			cylinder(r = 3 * 7/12, h = bearing_size, center = true, $fn = 6);
			translate([0, 0, bearing_size * sqrt(2) / 4 - 5]) rotate([180, 0, 0]) cylinder(r = 3, h = bearing_size, $fn = 30);
		}
		translate([0,0,16]) rotate([90,0,0]) rotate([0,0,22.5]) cylinder(r=16,h=bearing_size*2,$fn=8,center=true);
	}
	translate([0, 0,5]) rotate(90) rotate([90, 0, 90]) cylinder(r = (yz_motor_distance + motor_casing - motor_screw_spacing + 10) / 2, h = bearing_size + 10, center = true, $fn = 6);
}

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

module polycircle(r) {
    n = max(round(4 * r),3);
    rotate([0,0,180])
        circle(r / cos (180 / n), $fn = n);
}

module polyhole(r,h) {
    n = max(round(4 * r),3);
    rotate([0,0,180])
        cylinder(h = h, r = r / cos (180 / n), $fn = n);
}
