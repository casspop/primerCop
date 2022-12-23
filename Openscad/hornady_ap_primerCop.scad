// PrimerCop - a system that monitors the presence and completion
// of the priming process in a Hornady Lock-n-Load AP 5 station press.
//
// This file is the bottom bracket that holds the IR break-beam pair.
// Gregory A Sanders - December, 2022
// v1.1.0
// printed with PLA at 100% infill


scrdia = 3.2;
scrlen = 15;
scrhddia = 14;
scrhddep = scrhddia / 2;

$fn=1240;

module base(){
    difference(){
        cube([3,34,148]);
        union(){
        translate([-10,7,6])
        rotate([0,90,0])
        screwHole();
        translate([-10,7,106])
        rotate([0,90,0])
        screwHole();
        }
    }
}

module screwHole(){
    union(){
    cylinder(20,d=scrdia,center=false); // screw shank
    cylinder(scrhddep,d=scrhddia,center=false); // screw head
    } 
}

module baseblock(){
    difference(){
        color("red")
        union(){
            cube([13,22.5,14]);
            translate([0,15.5,14])
            rotate([0,0,340])
            // cube([13,3,13]);
            hull(){
                cube ([13.85,.01,13]);
                translate([-1.1,3,0])
                cube ([13.85,.01,13]);
            };
        }

    translate([6,25,24])
    rotate([90,0,340])
    screwHole();
    }
}

module irgrip(){
    difference(){
        rotate([0,0,340])
        translate([-13.8,0,0])
        hull(){
            cube ([21+14,.01,14]);
            translate([-3,8,0])
            cube ([24+14,.01,14]);
        };
        color("blue")
        union(){
                rotate([0,0,340])
                translate([9,-8,6])
                cube([14,20,12]);
                translate([10,16,10])
                rotate([90,0,340])
                screwHole();
                translate([10,16,4])
                rotate([90,0,340])
                screwHole();
            }
    }
    color("orange")
        rotate([0,0,340])
        translate([9,8,0])
        cube([12,42,3]);


    color("green")
        rotate([0,0,340])
        translate([-11,40,0])
            cube([20,10,3]);
    
    color("magenta")
        rotate([0,0,340])
        translate([-11,50,0]) 
            cube([32,3,14]);
}

module rtSensHole(){
        rotate([110,90,0])
        translate([-11,11,-61]) // x = z : y = x : z = y
            screwHole();
}


module gripblock(){
    translate([13,-21,0])
    irgrip();
}

difference(){
union(){
    baseblock();
    translate([0,35,0])
    gripblock();
}

    rotate([110,90,0])
    translate([-11,13,-81]) // x = z : y = x : z = y
        screwHole();


}
// }