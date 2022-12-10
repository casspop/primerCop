// tinyZipTieMnt.scad - A Tiny Ziptie Mount
// 2022 - Gregory A. Sanders
//
$fn=120;

module mnt(){
difference(){
cube([10,7,8]);
union(){
    rotate([0,90,0])
    translate([-7.5,3.5,-1.5])
    cylinder(12,d=10);
}
rotate([0,0,90])
translate([-4,-6.5,.5])
cube([16,3,1.5]);
translate([-1,-1,3.5])
cube([14,10,10]);
}
}

mnt();