// hornady_1602_LCD_mount.scad - LCD Mount for PrimerCop
// 2022 - Gregory A Sanders
//
// hole dims: 75 x 31mm  2.85mm dia.
// min interior box dims: 19 deep; 36 tall; 80 wide
//
// * disable
// ! show only
// # highlight
// % transparent
// hole for 3mm sheetmetal screw = 2.7
// hole for 3mm machine screw = 3.2

use <1602A-4 LCD.scad>; // This allows you to call functions from the specified file.
use <ArticArm1602_base.scad>;
use <3mmSocketHeadHole.scad>;
$fn=120;

module thruholes(){
    translate([2.5,2.5,17.5])
        cylinder(86,d=3.2,center=true);
    translate([33.5,2.5,17.5])
        cylinder(86,d=3.2,center=true);
    translate([2.5,77.5,17.55])
        cylinder(86,d=3.2,center=true);
    translate([33.5,77.5,17.5])
        cylinder(86,d=3.2,center=true);
    translate([26.5,63,0])
        cylinder(h = 30, r = 3,center=true);
    translate([15,63,0])
        cylinder(h = 30, r = 4,center=true);
}

module topscrewleg(){
        cube([5,5,6.8],center=true);
}

module topstandoffs(){
    translate([2.6,2.6,17.5])
        topscrewleg();
    translate([33.4,2.6,17.5])
        topscrewleg();
    translate([2.6,77.4,17.55])
        topscrewleg();
    translate([33.4,77.4,17.5])
        topscrewleg();
}

module screwleg(){
    difference(){
        // cube([5.5,5.5,8],center=true);
        cube([5.5,5.5,16],center=true);
        cylinder(86,d=2.7,center=true);
    }
}

module standoffs(){
    translate([2.5,2.5,4])
        screwleg();
    translate([33.5,2.5,4])
        screwleg();
    translate([2.5,77.5,4])
        screwleg();
    translate([33.5,77.5,4])
        screwleg();
}

module window(){
    cube([18,67,10]);
}
module topridge(){
    difference(){
    cube([35,79,4]);
    translate([2,2,-1])
    cube([31,75,6]);
}
}
module top(){
    
    difference(){
        union(){
            translate([.5,.5,17])
            color("magenta")
            topridge();
            translate([-2,-2,19.7])
            // cube([40,84,22]);
            color("blue")
            cube([40,84,2]);
            translate([0,0,-1])
            color("red")
            topstandoffs();
        }
        // union(){
            // thruholes();
            translate([9,6.5,14])
            window();
        // }
    }
}

module bottom(){
    difference(){
        union(){
            translate([-2,-2,0])
            cube([40,84,19.7]);
        }
        difference(){
            translate([0,0,2])
            cube([36,80,18]);
            standoffs();
        }
    }
}


module composite(){
    difference(){
        top();
        thruholes();
    }
    difference(){
        union(){
            bottom();
            rotate([180,0,0])
            translate([3,-55,0])
            aacomposite();

    }
    thruholes();
    translate([9,40,-8])
    SocHdHole();  
    translate([27,40,-8])
    SocHdHole();
    }
}
composite();
translate([0,0,12])
LCD1602A();

// screwleg();
// standoffs();
