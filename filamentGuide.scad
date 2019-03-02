tol = 0.1;

horizontalBearerDiam = 10;
horizontalBearerZ = 5;
footZ = 70;
baseSide = 30;
baseZ = 3;
removedRingDiam = baseSide - horizontalBearerDiam;

screwDiam = 3;
screwHeadDiam = 5;
screwHeadZ = 2;

difference() {
  foot();
  footScrewHoles();
}

module foot() {

  translate([-baseSide/2, -baseSide/2, 0])
    cube([baseSide, baseSide, baseZ]);
  difference() {
    translate([0, 0, baseZ])
      cylinder(d = baseSide, h=removedRingDiam/2);
    translate([0, 0, removedRingDiam/2 + baseZ])
    rotate_extrude(convexity = 10, $fn = 100)
      translate([(horizontalBearerDiam + removedRingDiam)/2, 0, 0])
        circle(d = removedRingDiam, $fn = 100);
  }
  scale([1.1, 1, 1])
    cylinder(d = horizontalBearerDiam, h = footZ*2/3, $fn=100);

  translate([0, 0, footZ*2/3])
    axle(footZ/3, horizontalBearerDiam, tol);

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