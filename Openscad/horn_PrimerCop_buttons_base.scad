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

module buttonhole(){
                cube([4,7,7]);
                cube([40,1,1]);
                translate([0,6,0])
                cube([40,1,1]);
                translate([0,6,6])
                cube([40,1,1]);
                translate([0,0,6])
                cube([40,1,1]);
                }

module buttonbase(){
    difference(){
        union(){
            translate([-6,0,0])
            cube([6,32,4]);
            translate([-6,0,0])
            rotate([0,-30,0])
            cube([6,32,14.5]);
            }
            union(){
                translate([-8.5,2.5,4])
                rotate([0,-30,0])
                #buttonhole();
                translate([-8.5,12.5,4])
                rotate([0,-30,0])
                #buttonhole();
                translate([-8.5,22.5,4])
                rotate([0,-30,0])
                #buttonhole();
            }
        }
}



module aacomposite(){
    // base();
    buttonbase();
}

aacomposite();
// buttonhole();
