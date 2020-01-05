// carrierPhotomask.scad - MR2020 caja carrier para photomask 
$fn = 100;
maskWidth = 5; // photomask size in inches
maskThickness = 90; // mil  (thousands of an inch)

convFactor = 25.4; // conversion factor to mm
convFactorMil = convFactor/1000; //conversion factor from mil to mm

maskWidthMM = maskWidth*convFactor;
maskThickMM = maskThickness*convFactorMil;
wallThickness = 1.5;
pinHeight = 2; // pin to hold the mask height in mm

width = maskWidth*convFactor + wallThickness*2 + 1; // added 1mm to ensure the mask fits 
depth = width ;
height = maskThickMM+2*pinHeight;
hingeOuter = 7;
hingeInner = 4;
hingeInnerSlop = .4;
hingeFingerSlop = .4;
fingerLength = hingeOuter/1.65;
fingerSize = 6.5;
topFingerSize = fingerSize;
pos = -depth/2;
latchWidth = 8;
z = 0;

mask();
bottom();
top();

// este es el módulo correcto para ver bien cómo queda la máscara, pero está comentado para correrla en el siguiente módulo hacia un costado así veo cómo se van montando las dimensiones.
//module mask(){
//	translate([-width + wallThickness - fingerLength +0.5 , -maskWidthMM/2 ,maskThickMM ]){
//		color([1,0,1])
//		cube(size=[maskWidthMM,maskWidthMM, maskThickMM]);
//	}
//	
//}


module mask(){
	translate([-width + wallThickness - fingerLength +0.5 , 0 ,maskThickMM ]){
		color([1,0,1])
		cube(size=[maskWidthMM,maskWidthMM, maskThickMM]);
	}
	
}

module bottom() {
	color([1,0,0])
	union() {
		// main box and cutout
		difference() {
			translate([-width - fingerLength, -depth/2, 0]) {
				cube([width,depth,height]);
			}
	
			translate([(-width - fingerLength) + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), height]);
			}

			// latch cutout
			translate([-width - fingerLength + (wallThickness/2), (-latchWidth/2) - (hingeFingerSlop/2), wallThickness]) {
				cube([wallThickness/2 + .1, latchWidth + hingeFingerSlop, height]);
			}

						
		}

		//latch cylinder
		difference() {
			translate([-width - fingerLength + (wallThickness/2), -latchWidth/2, height - 1]) {
				rotate([-90,0,0]) {
					cylinder(r = 1, h = latchWidth);
				}
			}
			// front wall wipe
			translate([-width - fingerLength - 5, -depth/2,0]) {
				cube([5,depth,height]);
			}
		}

		difference() {
			hull() {
				translate([0,-depth/2,height]) {
					rotate([-90,0,0]) {
						cylinder(r = hingeOuter/2, h = depth);
					}
				}
				translate([-fingerLength - .1, -depth/2,height - hingeOuter]){
					cube([.1,depth,hingeOuter]);
				}
				translate([-fingerLength, -depth/2,height-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,height]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts

			for  (i = [-depth/2 + fingerSize:fingerSize*2:depth/2]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,height*2]);
				}
			}
		}

		// center rod
		translate([0, -depth/2, height]) {
			rotate([-90,0,0]) {
				cylinder(r = hingeInner /2, h = depth);
			}
		}
	}
}

module top() {
	union() {
		difference() {
			translate([fingerLength, -depth/2, 0]) {
				cube([width,depth,height - .5]);
			}
	
			translate([fingerLength + wallThickness, -depth/2 + wallThickness, wallThickness]) {
				cube([width - (wallThickness * 2), depth - (wallThickness * 2), height]);
			}

			
		}

		//latch
		translate([width + fingerLength - wallThickness - 1.5, (-latchWidth/2), 0]) {
			cube([1.5, latchWidth, height - .5 + 4]);
		}
		translate([width + fingerLength - wallThickness, -latchWidth/2, height - .5 + 3]) {
			rotate([-90,0,0]) {
				cylinder(r = 1, h = latchWidth);
			}
		}

		difference() {
			hull() {
				translate([0,-depth/2,height]) {
					rotate([-90,0,0]) {
						cylinder(r = hingeOuter/2, h = depth);
					}
				}
				translate([fingerLength, -depth/2,height - hingeOuter - .5]){
					cube([.1,depth,hingeOuter - .5]);
				}
				translate([-fingerLength/2, -depth/2,height-.1]){
					cube([fingerLength,depth,.1]);
				}
				translate([0, -depth/2,height]){
					rotate([0,45,0]) {
						cube([hingeOuter/2,depth,.01]);
					}
				}
			}
			// finger cutouts
			for  (i = [-depth/2:fingerSize*2:depth/2 + fingerSize]) {
				translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
					cube([fingerLength*2,fingerSize + hingeFingerSlop,height*2]);
				}
				if (depth/2 - i < (fingerSize * 1.5)) {
					translate([-fingerLength,i - (fingerSize/2) - (hingeFingerSlop/2),0]) {
						cube([fingerLength*2,depth,height*2]);
					}
				}
			}

			// center cutout
			translate([0, -depth/2, height]) {
				rotate([-90,0,0]) {
					cylinder(r = hingeInner /2 + hingeInnerSlop, h = depth);
				}
			}
		}
	}
}

