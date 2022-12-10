//ArticArm1602_sect.scad - Articulating Arm section for 1602 LCD
//2022 Gregory A Sanders
//
//
$fn=120;
module arm(){
    difference(){
    hull(){
        translate([0,5,0,])
        cylinder(10,d=10);
        cube([80,10,10]);
        translate([80,5,0])
        cylinder(10,d=10);
    }
    translate([0,5,-5])
    cylinder(20,d=3.2);
    translate([80,5,-5])
    cylinder(20,d=3.2);
}
}
arm();