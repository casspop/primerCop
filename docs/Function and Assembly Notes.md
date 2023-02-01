# Function and Assembly Notes

**--== These notes are in progress ==--**

## Function Notes

PrimerCop is a pretty simple piece of gear.  The bar on the press that retrieves and delivers the primers moves up and down with the turret plate.  We are putting IR break-beam sensors at the top and bottom of its travel to detect its location in the cycle.

The sensor at the top is triggered by the bar blocking the IR light.  When that happens, the program provides feedback to the user and increments the counter.

As the bar moves back down, the sensor is once again exposed to the IR emitter's output, and the software provides notification of that event.

When the bar reaches the bottom of its travel, the bottom sensor is deprived of IR and the software interprets that event as a primer is ready to be seated.  The buzzer begins sounding and continues until the handle of the press is moved forward to seat the primer in the case.

Moving the handle forward lowers the turret and the bar.  This exposes the sensor to the IR source and the software stops the buzzer and informs the user that the primer has been seated.

Releasing the handle once again blocks the sensor, and the software then reports the end of the cycle and how many primers have been used to that point.

## Assembly Notes: refer to the pictures in the ./img folder for reference

### Mounting sensor brackets

The top and bottom sensor brackets are held to the mount plate with Gorilla double-sided mounting tape.  This solution seems to be more than adequate.  Of course, screws and nuts could be used, but I don't see why that would be necessary at this point.

### IR sensor notes

The sensors themselves are not mounted exactly the same on top and bottom.  That is because the little primer sled moves out into the area where the top emitter would be if it were mounted exactly like the bottom emitter.  What I did was to dry-fit the emitter with the assembled PrimerCop mounted to the press.  I determined where a hole needed to be drilled in the top bracket so the emitter's LED could cast its beam toward the receiver.  Then I drilled said hole and mounted the emitter.

### Base plate thoughts

I made my baseplate out of a steel VESA adapter plate from a TV mount.  I've had a few of these for years, and it was perfect for this application.  I cut out what I needed.

After getting the PrimerCop working, I then made the OpenSCAD model to match the dimensions of my steel plate.  I printed it out and verified its fit on the press.  I'm of the opinion at this point that a 3D printed version of that plate in PLA or PETG with no infill (solid plastic) would be adequately stiff to be used in place of the steel plate I have.  Just a thought.

### Mounting electronics

The Drok power supply and the Pi Pico are mounted to the same plate.  The Drok converter has no holes for mount screws, so I have a channel for it to slide into.  It is a bit too tight, but I was able to work it into position.  I made a version 2 of the hardware with about 1.0mm added to make it less tight. That's what is in the SCAD and STL folders now.

There are holes in the mount plate for 2.5mm standoff screws.  Attach standoffs using those screws and mount the Pico to the standoffs.

Once you have both pieces of hardware mounted to their mount plate, affix it to the steel plate with 3 or 4 smallish pieces of Gorilla mounting tape.

### Display notes

The same snugness problem that I encountered with the Drok converter reared its ugly head with the display mount.  I will be adding some space to the interior of that model as well.  It =does= fit, but it's really tight.  Not so tight as to cause alarm, but too tight for easy assembly.

I also will be enlarging and moving the LCD contrast adjustment hole to more correctly align it with the potentiometer on the i2c board.  For the time being, I simply drilled it out larger so I could access the pot.

### Wire routing

As you assemble your parts, you will need to account for routing and dressing your wires.  I created the 'tinyZipTieMnt' model and I used it in several places where I needed them to keep wires under control.

I used a typical superglue (Cyanoacrylate) product.  I noticed it seemed to take an unusual amount of time for this glue to set on the plastic.  If I could be patient or distract myself with something long enough, it would eventually set.  Once it did, it was quite permanent.

You may need to drill some holes for zip ties in some areas.  Use your own judgement.

### Wiring diagram notes

There currently is no wiring diagram.  I may fix that later, but it's not a high priority.

- The i2c circuit is typical.
- I landed 12vdc from the Drok on the VSYS pad.  I had it on the VBUS pad originally, but moved it while trying to comprehend the parameters of using USB for programming without unplugging the Drok supply.  In the end, I just left my 12vdc supply connected to VSYS.  VBUS may be a better choice, but it also has a voltage drop from a diode.  No biggie, but it is there.
- Where to land the sensors and switches can be determined by reading the Python program file.  easy peasey
- Be very careful to provide solid power and ground connections between the Drok converter and the Pico.
  - If you, like I, use the phoenix connector on the Drok, make sure you get all your conductors solidly screwed down.  
  - This does NOT mean tighten the screw more.  It means strip off enough insulation to expose enough conductor so when you twist them all together they are long enough to fit deep into the connector, but not so long as to have bare conductor sticking out more than 1/32" or so.  If you need to, pull them back out and trim them off a bit.
- I create a splice point inline when I have a bunch of wires all going to the same place.  Just twist them together using a modified [linemans splice](../img/lineman-splice.jpg) (simplified) with one wire exiting to solder to the termination point.  The appropriate piece of heat shrink tube tops it off nicely.
