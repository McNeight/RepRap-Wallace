// RepRap Wallace  
// Configuration file
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <MCAD/units/us.scad>;
include <MCAD/hardware/linear_bearing.scad>;
include <MCAD/motors/stepper.scad>;

thin_wall = 3;

// RODS
// Diameter for clearance, not tapping
// Swap 1/4-20 for M6x1.0
threaded_rod_diameter = 6.5278;
threaded_rod_diameter_horizontal = 6.5278;
// Use 5/16 smooth rod, which is close to M8
// 8mm linear bearing are currently MUCH cheaper than anything else
//smooth_bar_diameter = 7.97;
//smooth_bar_diameter_horizontal = 8.3;
smooth_bar_diameter = 12.0;
smooth_bar_diameter_horizontal = 12.0;

// Nuts and bolts
// Diameter for clearance, not tapping
//m8_diameter = 9;
//iso4032 says Width across corners = 14.38
//m8_nut_diameter = 14.1;

// Swap 5/16-18 for M8x1.25
//m8_diameter = 8.4; // 0.3320 inch
//m8_nut_diameter = 12.7; // 1/2 inch

// Could be M8, could be M6, could be 1/4"
// Changed name to threaded_rod_nut_diameter
threaded_rod_nut_diameter = length_in(0.438); // 7/16 inch; Width across the flats Max: 	0.438"

// Swap 1/4-20 for M6x1.0
//m6_diameter = 6.35; // 1/4 inch
// 1/4" nuts require a 7/16" wrench
//m6_nut_diameter = 11.113; // 7/16 inch

//m4_diameter = 4.7;
//iso4032 says 7.66
//m4_nut_diameter = 7.6;
//m4_nut_diameter_horizontal = 8.15;

// Swap #6-32 for both M4x0.7 and M3x0.5
//m4_diameter = 3.8; // 0.1495 inch
//m4_nut_diameter = 7.8; // 5/16 inch
m4_diameter = length_inch(0.1495);
m4_nut_diameter = length_inch(0.312); // 5/16 inch; Width across the flats Max: 	0.312"
//m4_nut_diameter = 8.3; // 5/16 inch plus 0.5 mm

//m3_diameter = 3.6;
//iso4032 says 6.01
//m3_nut_diameter = 5.3;
//m3_nut_diameter_horizontal = 6.8;
//m3_washer_diameter = 6.9;

//m3_diameter = 3.8; // 0.1495 inch
m3_diameter = length_inch(0.1495);
m3_nut_diameter = length_inch(0.312); // 5/16 inch; Width across the flats Max: 	0.312"
//m3_nut_diameter = 8.3; // 5/16 inch plus 0.5 mm
m3_nut_diameter_horizontal = 9.3;

// Bushing holder
bushing_core_diameter = smooth_bar_diameter;
bushing_material_thickness = 1;

// Motors
// Stepper motor shafts are still metric
motor_shaft = 5.5;

///counted stuff
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;

fudgeSize = 1.0;

linear_bearing_model = "LM12UU";
bearing_size = linearBearing_D(linear_bearing_model);
bearing_length = linearBearing_L(linear_bearing_model);
yz_motor_distance = 4 * smooth_bar_diameter;
stepper_motor_model = Nema14;
stepper_motor_size = NemaLong; // NemaShort, NemaMedium, NemaLong
motor_screw_spacing = motorScrewSpacing(stepper_motor_model);
motor_casing = motorWidth(stepper_motor_model); //38 for NEMA14, 45 for NEMA17
end_height = motorLength(model=stepper_motor_model, size=stepper_motor_size) + 4; //measure the height of your motor casing and add 4mm. Suggestion: 40 for NEMA14, 55 for NEMA17

bed_mount_height = 16;
//x_rod_spacing = motor_screw_spacing + 3 + rod_size;
x_rod_spacing = 30;
x_carriage_width = 70;
carriage_extruder_offset = 5;
pulley_size = 20;
idler_pulley_width = 10;
// 623Z id=3 od=10 w=4
// 608ZZ id=8, od=22, w=8
idler_bearing_size = 10;
gusset_size = 15;
// Stepper motor shafts are going to be 5mm
motor_shaft_size = 5;
build_volume = [140, 210, 110];
printbed_screw_spacing = [170, 220];

// Extruder fan mount
fan = true;
fan_hole_separation=32;
fan_support_block=9;
fan_trap_width=3;
fan_support_thickness=9;
fan_diameter=36;
fan_hole_height=4;

