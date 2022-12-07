// PrimerCop - a system that monitors the presence and completion
// of the priming process in a Hornady Lock-n-Load AP 5 station press.
// Gregory A Sanders - November, 2022
//


scrdia = 5;
scrlen = 100;
scrhddia = 14;
scrhddep = scrhddia / 2;
//
// the main back mounting plate is 2.67mm thick.
//
$fn=1240;

module screwHole(){
    union(){
    cylinder(scrlen,d=scrdia,center=false); // screw shank
    cylinder(scrhddep,d=scrhddia,center=false); // screw head
    } 
}

module baseblock(){
    // difference(){
        color("red")
        union(){
            cube([13,22.5,14]);
            translate([0,15.5,-26])
            rotate([0,0,340])
            // cube([13,3,13]);
            hull(){
                cube ([35,.01,40]);
                translate([-1.1,3,0])
                cube ([35,.01,40]);
            };
        }

    // translate([6,22,24])
    // rotate([90,0,340])
    // #screwHole();
    // }
}

module irgrip(){
    // difference(){
        rotate([0,0,340])
        translate([-13.8,0,0])
        hull(){
            cube ([35,.01,14]);
            translate([-3,8,0])
            cube ([35,.01,14]);
        };
    //     color("blue")
    //         rotate([0,0,340])
    //         translate([9,-8,11])
    //         cube([14,20,6]);
    // }
    color("orange")
        rotate([0,90,340])
        translate([-14,0,0])
        cube([14,50,3]);

    color("purple")
        rotate([0,0,340])
        translate([0,8,11])
        cube([12,42,3]);

    // color("green")
    //     rotate([0,0,340])
    //     translate([-11,40,0])
    //         cube([20,10,3]);
    
    color("magenta")
        rotate([0,0,340])
        translate([-11,50,-26]) 
            cube([32,3,40]);
}

// module rtSensHole(){
//         rotate([110,90,0])
//         translate([-11,11,-61]) // x = z : y = x : z = y
//             #screwHole();
// }


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
    translate([20,13,-81]) // x = z : y = x : z = y
        #screwHole();


}
// }