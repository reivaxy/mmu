tol = 0.1;

horizontalBearerIntDiam = 10;
horizontalBearerExtDiam = 19;
horizontalBearerZ = 5;

verticalBearerIntDiam = 4;
verticalBearerExtDiam = 13;
verticalBearerZ = 5;

footZ = 70;
baseSide = 30;
baseZ = 3;
removedRingDiam = baseSide - horizontalBearerIntDiam;

screwDiam = 3;
screwHeadDiam = 5;
screwHeadZ = 2;

headBottomSide = horizontalBearerExtDiam + 4;
headBottomZ = horizontalBearerZ + 1;
hookY = 1;
hookX = 5;

//head();
//piercedFoot();
guide();

module guide() {
  rotate(90,[0, -1, 0])
  difference() {
    cube([10, 10, 10]);
    translate([5, 5, 0]) {
      cylinder(d=4+tol, h=9, $fn=50);
      cylinder(d=2, h=11, $fn=50);
    }
  }
  axleLength = headBottomSide/2 -10 + 2* hookX;
  translate([-5, 5, 10])
    axle(axleLength, verticalBearerIntDiam, tol);
}

module head() {
  translate([-40, 0, 0])
  headBottom(hookX, hookY);
  /*
  translate([-11.8, headBottomSide, headBottomSide + hookX- hookY])
  rotate(90, [0, 1, 0])
    rotate(180, [1, 0, 0])
  */
      headTop(hookX, hookY);
}

module headTop(hookX, hookY) {
  moreX = 10;
  deoubleTol = 2*tol;
  difference() {
    cube([headBottomSide + moreX + hookX, headBottomSide, headBottomZ]);
    translate([headBottomSide/2, headBottomSide/2, 0]) {
      translate([0, 0, 1]) {
        cylinder(d=verticalBearerExtDiam + tol, h=verticalBearerZ, $fn=100);
      }
      cylinder(d=verticalBearerExtDiam - 5, h=headBottomZ + 1, $fn=100);
    }
    color("red")
    translate([headBottomSide - 2*hookY - deoubleTol + moreX, 0, 0]) {
      cube([headBottomZ + deoubleTol, hookY + tol, headBottomZ]);
      translate([0, headBottomSide - hookY - tol, 0])
        cube([headBottomZ + deoubleTol, hookY + tol, headBottomZ]);
      translate([0, 0, headBottomZ - 2*hookY - tol])
        cube([headBottomZ + deoubleTol, headBottomSide, headBottomZ]);
    }
  }
}

module headBottom(hookX, hookY) {
  difference() {
    cube([headBottomSide + hookX, headBottomSide, headBottomZ]);
    translate([headBottomSide/2, headBottomSide/2, 0]) {
      translate([0, 0, 1]) {
        cylinder(d=horizontalBearerExtDiam, h=horizontalBearerZ, $fn=100);
      }
      cylinder(d=horizontalBearerExtDiam - 5, h=headBottomZ + 1, $fn=100);
    }
    translate([headBottomSide, hookY, 0]) {
      cube([hookX - hookY, headBottomSide - 2* hookY, headBottomZ]);
      translate([hookY, hookY, 0]) {
        cube([hookX - hookY, headBottomSide - 4* hookY, headBottomZ]);
      }
      translate([hookX, 0, 0]) {
        rotate(45, [0, 0, 1])
          cube([3, 3, headBottomZ]);
      }
      translate([hookX, headBottomSide - 3*hookY - 3, 0]) {
        rotate(45, [0, 0, 1])
          cube([3, 3, headBottomZ]);
      }
    }
  }

}

module piercedFoot() {
  difference() {
    foot();
    footScrewHoles();
  }
}

module foot() {
  translate([-baseSide/2, -baseSide/2, 0])
    cube([baseSide, baseSide, baseZ]);
  difference() {
    translate([0, 0, baseZ])
      cylinder(d = baseSide, h=removedRingDiam/2);
    translate([0, 0, removedRingDiam/2 + baseZ])
    rotate_extrude(convexity = 10, $fn = 100)
      translate([(horizontalBearerIntDiam + removedRingDiam)/2, 0, 0])
        circle(d = removedRingDiam, $fn = 100);
  }
  scale([1.1, 1, 1])
    cylinder(d = horizontalBearerIntDiam, h = footZ*2/3, $fn=100);

  translate([0, 0, footZ*2/3])
    axle(footZ/3, horizontalBearerIntDiam, tol);

}

module baseScrewHole(depth) {
  cylinder(d=screwHeadDiam, h=10, $fn=50);
  translate([0, 0, -screwHeadZ])
    cylinder(d2=screwHeadDiam, d1=screwDiam, h=screwHeadZ, $fn=50);
  translate([0, 0, -depth - screwHeadZ])
    cylinder(d=screwDiam - tol, h=depth, $fn=50);
}

module footScrewHoles() {
  offset = screwDiam/2 + 3;
  translate([-baseSide/2, -baseSide/2, 0]) {
    translate([offset, offset, baseZ])
      baseScrewHole(10);
    translate([baseSide - offset, offset, baseZ])
      baseScrewHole(10);
    translate([baseSide - offset, baseSide - offset, baseZ])
      baseScrewHole(10);
    translate([offset, baseSide - offset, baseZ])
      baseScrewHole(10);

  }
}

module axle(axleHeight, axleDiam, tolerance) {
  thinner = 2.5;
  barWidth = 1.8;
  difference() {
    scale([1.1, 1, 1])
      cylinder(d=axleDiam - 2*tolerance, h=axleHeight, $fn=150);
    scale([1.4, 1, 1])
      cylinder(d=axleDiam-thinner, h=axleHeight, $fn=150);
    translate([-axleDiam, -1/2, 0])
      cube([axleDiam * 2, 1, axleHeight]);
  }
  rotate([0, 0, 50])
    translate([-axleDiam/2 + 0.1, -barWidth/2, 0])
      cube([axleDiam - 0.2, barWidth, axleHeight]);
}