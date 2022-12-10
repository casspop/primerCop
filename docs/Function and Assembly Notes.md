# Function and Assembly Notes

**--== These notes are in progress ==--**

## Function Notes

PrimerCop is a pretty simple piece of gear.  The bar on the press that retrieves and delivers the primers moves up and down with the turret plate.  We are putting IR break-beam sensors at the top and bottom of its travel to detect its location in the cycle.

The sensor at the top is triggered by the bar blocking the IR light.  When that happens, the program provides feedback to the user and increments the counter.

As the bar moves back down, the sensor is once again exposed to the IR emitter's output, and the software provides notification of that event.

When the bar reaches the bottom of its travel, the bottom sensor is deprived of IR and the software interprets that event as a primer is ready to be seated.  The buzzer begins sounding and continues until the handle of the press is moved forward to seat the primer in the case.

Moving the handle forward lowers the turret and the bar.  This exposes the sensor to the IR source and the software stops the buzzer and informs the user that the primer has been seated.

Releasing the handle once again blocks the sensor, and the software then reports the end of the cycle and how many primers have been used to that point.

## Assembly Notes

### Mounting sensor brackets

The top and bottom sensor brackets are held to the mount plate with Gorilla double-sided mounting tape.  This solution seems to be more than adequate.  Of course, screws and nuts could be used, but I don't see why that would be necessary at this point.

### IR sensor notes

The sensors themselves are not mounted exactly the same on top and bottom.  That is because the little primer sled moves out into the area where the top emitter would be if it were mounted exactly like the bottom emitter.  What I did was to dry-fit the emitter with the assembled PrimerCop mounted to the press.  I determined where a hole needed to be drilled in the top bracket so the emitter's LED could cast its beam toward the receiver.  Then I drilled said hole and mounted the emitter.

### Base plate thoughts

I made my baseplate out of a steel VESA adapter plate from a TV mount.  I've had a few of these for years, and it was perfect for this application.  I cut out what I needed.

After getting the PrimerCop working, I then made the OpenSCAD model to match the dimensions of my steel plate.  I printed it out and verified its fit on the press.  I'm of the opinion at this point that a 3D printed version of that plate in ABS with no infill (solid plastic) would be adequately stiff to be used in place of the steel plate I have.  Just a thought.



