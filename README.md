# Design notes related to 3D printing this design

Original design taken from http://domoticx.com/3d-ontwerp-scad-hinged-box-with-latch/, after it was changed to my end.





Notes form the original design:



Thingiverse commentaar:
I searched the Thingiverse for a simple hinged box that was parametric and printed all in one piece. I couldn’t find one. I did find some really neat parametric boxes and lids though. I used none of their OpenSCAD code for this.

I’ve printed probably a dozen one piece boxes with hinge during my testing. I wanted a tight hinge that would reliably print and NOT fuse together. During my testing I experimented with different speeds, temps, and tolerance values in my SCAD files. The attached OpenSCAD files prints reliably on my printer. The resulting hinge is a bit loose but it reliably does not fuse. Changing the tolerance by .1 does make a much tighter hinge, but sometimes I could not break it free. YMMV.

I searched the Thingiverse for a simple hinged box that was parametric and printed all in one piece. I couldn’t find one. I did find some really neat parametric boxes and lids though. I used none of their OpenSCAD code for this.

I’ve printed probably a dozen one piece boxes with hinge during my testing. I wanted a tight hinge that would reliably print and NOT fuse together. During my testing I experimented with different speeds, temps, and tolerance values in my SCAD files. The attached OpenSCAD files prints reliably on my printer. The resulting hinge is a bit loose but it reliably does not fuse. Changing the tolerance by .1 does make a much tighter hinge, but sometimes I could not break it free. YMMV.

Instructions
You’ll need a fairly dialed in printer to do this. If your printer calibration is way off, you won’t get a good hinge mechanism.

I printed this one with:

Layer Height: .15
Infill: 100%
First Layer Speed: 40mm/s
Speed: 80mm/s
Shells: 2

I’m using MakerWare. I used to think it was crap but I’m getting really good results with recent versions. In MakerWare:

feedDiameter: 1.77 (caliper measured 1.75mm filament)
feedstockMultiplier: 0.87
retractDistance: 1.0
retractRate: 20.0
restartExtraDistance: 0.0

If your filament delivery system is not tuned up, you’ll probably get a hinge that’s fused together and will not fold.

The OpenScad file is not idiot-proof. You have to supply a width, depth and height for the box. These are the outside dimensions make sure you add in the wall thickness if you need these to mean inside dimensions of the box.

Once you change the depth value, you’ll probably need to manually adjust the size of the hinge fingers so you get a reasonable distribution of the fingers and you don’t get a missing finger or a really thin finger that won’t print, or would be very weak.

Also, do not scale this down and try and print it. The hinge will be fused together.
