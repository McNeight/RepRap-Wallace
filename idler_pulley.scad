include <config.scad>;

for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + 3), y * (pulley_size / 2 + 3), 0]) idler_pulley(true);

module idler_pulley(double_bearing = true) difference() {
	cylinder(r=pulley_size / 2,h=idler_pulley_width);
}

