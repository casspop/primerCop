# Function and Assembly Notes

<span style="color:red;"> ## These notes are in progress</span>

## Function Notes

PrimerCop is a pretty simple piece of gear.  The bar on the press that retrieves and delivers the primers moves up and down with the turret plate.  We are putting IR break-beam sensors at the top and bottom of its travel to detect its location in the cycle.

The sensor at the top is triggered by the bar blocking the IR light.  When that happens, the program provides feedback to the user and increments the counter.

As the bar moves back down, the sensor is once again exposed to the IR emitter's output, and the software provides notification of that event.

When the bar reaches the bottom of its travel, the bottom sensor is deprived of IR and the software interprets that event as a primer is ready to be seated.  The buzzer begins sounding and continues until the handle of the press is moved forward to seat the primer in the case.

Moving the handle forward lowers the turret and the bar.  This exposes the sensor to the IR source and the software stops the buzzer and informs the user that the primer has been seated.

Releasing the handle once again blocks the sensor, and the software then reports the end of the cycle and how many primers have been used to that point.

