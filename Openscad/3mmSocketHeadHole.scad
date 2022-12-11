//3mmSocketHeadHole.scad - Dr.Gerg's 3mm Socket Head Hole
//
// OpenSCAD definition file
// https://www.drgerg.com
// PARAMETER DEFINITIONS
    cylaH = 4.2;
    cylaD = 6.4;
    cylbH = 12;
    cylbD = 3.3;
module SocHdHole(){
    $fn=48;
    cylinder(cylaH,d=cylaD,false);
    translate([0,0,cylaH-1])
    cylinder(cylbH,d=cylbD,false);
}
SocHdHole();