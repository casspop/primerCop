//Dr.Gerg's i2c interface board
// for 1602A-4 16x2 and 2004 20x4 LCD modules
// OpenSCAD definition file
// https://www.drgerg.com


module hw061(){
    pcb = [18.85,41.72,1.56];
    module pin(tx,ty,tz,ry,cl,cx,cy){
        translate([tx,ty,tz])
        rotate([0,ry,0])
        cube([cl,cx,cy],false);
    }

    $fn=48;
    difference(){
    color("gray")
    cube(pcb);
    translate([1.64,1.64,-.5])
    rotate([0,0,90])
    for (i=[0:15])
        pin(i*2.54,0,0,270,3,.64,.64);
    translate([6.98,1.64,-.5])
    rotate([0,0,0])
    for (i=[0:1])
        pin(i*2.54,0,0,270,3,.64,.64);
    translate([5.55,pcb.y-1.64,-.5])
    rotate([0,0,0])
    for (i=[0:3])
        pin(i*2.54,0,0,270,3,.64,.64);
    }
    color("lightblue")
    translate([4.27,27.14,pcb.z])
    cube([6.75,6.75,5.15]);
    translate([4.27+3.375,27.14+3.375,pcb.z+4.2])
    color("blue")
    cylinder(1,r=3);
    color("black")
    translate([4.27,15.88,pcb.z])
    cube([10.4,7.4,2]);
}
hw061();