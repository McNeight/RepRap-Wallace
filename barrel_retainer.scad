include <config.scad>;

projection(cut=true) barrel_retainer();

echo(barrel_dia-2);

module barrel_retainer(){
    difference(){
    	union() {
    	    translate([-20,1-6.5,-2]) cube([40,12,4]);
    	    translate([20-12,5-17,-2]) cube([12,17,4]);
    	}
	    for(i=[1,-1]) translate([i*(x_carriage_width/2 - 4),2,-6]) {
	        cylinder(r=3/2,h=12,$fn=24);
	    }
	    translate([1.5,0,-6]) cylinder(r=(barrel_dia-2)/2,h=12,$fn=24);
	    translate([1.5,5,0]) cube([barrel_dia-2,10,4.2],center=true);
	    translate([x_carriage_width/2 - 6,-13,0]) cylinder(r=4,h=4.2,center=true,$fn=6);
	    translate([x_carriage_width/2 - 6,-6.5,0]) cube([4,2,4.2],center=true);
    }
}


