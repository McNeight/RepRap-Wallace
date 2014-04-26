include <wallace.scad>;

!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -smooth_bar_diameter, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();