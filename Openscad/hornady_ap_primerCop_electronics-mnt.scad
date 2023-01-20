// PrimerCop - a system that monitors the presence and completion
// of the priming process in a Hornady Lock-n-Load AP 5 station press.
// Gregory A Sanders - November, 2022
//
// Electronics Mounting
//
pwrsupplywidth=28;
pwrsupplylength=63.6;
pwrsupplythick=1.8;
picomntholesw=12;
picomntholesl=47;
// mm2screwhole=2.1;
// overall 90 x 54;
// widths are Y
// lengths are X
$fn=240;
module base(){
    cube([90,54,3]);
}

module ps(){
    difference(){
        cube([pwrsupplylength+2,pwrsupplywidth+3,10]);
        translate([-1,3,0])
        difference(){
            union(){
                translate([0,-.5,0])
                cube([pwrsupplylength+4,pwrsupplywidth-2,11]);
                translate([3,-1.5,7])
                cube([pwrsupplylength+2,pwrsupplywidth,pwrsupplythick]);
            }
        }
    }
}

module picoscrew(){
    union(){
        cylinder(20,1.05);
        cylinder(2,r=2);
    }
}

module keyslot(){
    rotate([90,0,90])
    linear_extrude(height = 20) 
    polygon(points=[[0,0],[1,4],[7,4],[8,0]]);
}



module pico(){
    picoscrew();
    translate([0,picomntholesw,0])
    picoscrew();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    translate([picomntholesl,picomntholesw,0])
    picoscrew();
    translate([picomntholesl,0,0])
    picoscrew();
}

difference(){
    union(){
        base();
        translate([0,54-pwrsupplywidth-6,0])
        ps();
    }
    translate([10,3,-1])
    pico();
    translate([71,16,1.5])
    keyslot();
}
