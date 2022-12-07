// ArticArm1602_base.scad - Articulating Arm Mount for 1602A LCD
// 2022 Gregory A Sanders
//
//
// hole for 3mm machine screw = 3.2
//

use <3mmSocketHeadHole.scad>

$fn=120;
module base(){
    difference(){
        cube([30,32,4]);
        rotate([180,0,0])
        translate([6,-15,-6])
        SocHdHole();      
        rotate([180,0,0])
        translate([24,-15,-6])
        SocHdHole();

    }
}

module pivot(){
    difference(){
        translate([0,0,12.5])
        rotate([90,0,0])
        hull(){
            cylinder(10,d=15,center=true);
            translate([0,-7.5,0])
            cube([15,10,10],true);
        }
        union(){
        translate([0,0,12.5])
        rotate([90,0,0])
        cylinder(30,d=3.2,center=true);

        }
    }
}

module aacomposite(){
    base();
    translate([15,5,0])
    pivot();
    translate([15,27,0])
    pivot();
}

aacomposite();
