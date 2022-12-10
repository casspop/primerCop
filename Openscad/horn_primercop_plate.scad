// horn_primercop_plate.scad - 2022 Gregory A Sanders
// Template for the steel plate everything else is mounted on.
// corners filleted with 5mm radius
// 3mm steel thickness (c. 1/8")
// 76.28 total width
// 152.5 total height
// 33 peninsula width
// 23 peninsula height
// 12.67 large radius
// 10 corner radius
// 99.93mm (3-15/16") mount hole vertical spacing
// 11.75 mount holes from left edge and bottom
// 17/64" (6.76mm) holes (just larger than 1/4")

$fn=120;

module mountholes(){
    union(){
        cylinder(10,r=3.38,center=true);
        translate([99.93,0,0])
        cylinder(10,r=3.38,center=true);
    }
}

module base(){
    minkowski(){
        translate([10,0,0])
        cube([132.5,46.3,2]);
        cylinder(1,r=5,center=true);
    }
}

module lowerright(){
    minkowski() {
        cube([13,28,2]);
        cylinder(1,r=5,center=true);
    }
}
module left(){

    minkowski() {
        translate([23,46.28,0])
        cube([119.5,20,2]);
        cylinder(1,r=5,center=true);
    }

    
}

module final(){
    difference(){
        base();
        union(){
                translate([5.33,45.67,0])
                cylinder(10,r=12.67,center=true);
                translate([-17,45.67,-1])
                cube([40,40,10]);
                translate([-24.67,33,-1])
                cube([30,20,10]);
                }
            }
    lowerright();
    difference(){
        left();
        translate([18+(11.75),-5+(76.28-11.75),0])
        mountholes();
    }
}

translate([5,5,.5])  // to offset minkowski add.
final();

// translate([0,60,0])  // use these to check overall measurements
// color("red")
// cube([152.5,20,3]);
// translate([0,60,0])
// color("red")
// cube([23,20,3]);