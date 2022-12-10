// piezobuzzermount.scad - A Mount for a piezo buzzer.
// 2022 - Gregory A Sanders
//
$fn=120;
module spkr(){
    difference(){
        cylinder(h=10, d=14);
        union(){
            translate([0,0,-1])
            cylinder(h=12, d=11.7);
            translate([-3,-8,-1])
            cube([6,16,16]);
        }
    }
}

module squareparts(){
    difference(){
        union(){
            cube([2,14,16]);
            cube([14,14,2]);
        }
        translate([-1,5,3])
        cube([4,4,10]);
    }
}

rotate([0,90,0])
translate([-8,7,2])
spkr();
squareparts();