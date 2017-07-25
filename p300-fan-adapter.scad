// Base measurements

// Projector air grille
rectWidth = 52.38;
rectHeight = 30.16;

// Projector air grille pegs
pegHeight = 4;
pegDiameter = 2.175;

// External fan
circleRadius = (92 / 2);
circularFlangeScrewHoleDistance = 82.5;
screwHoleDiameter=4.5;

// Adapter
extrusionHeight = 20;
rearFanDistanceAboveRectTop = 6.35;
flangeHeight = 2;
hullThickness = 3.175;

// Derived measurements
pegRadius = pegDiameter / 2;
halfHullThickness = hullThickness / 2;
halfRectWidth = rectWidth / 2;
halfRectHeight = rectHeight / 2;
 
 // Hexapegs
 
 // Bottom right (Looking at circle through rectangle)
 translate([-halfRectWidth + halfHullThickness, halfRectHeight - halfHullThickness, 0 ]) hexapeg(pegHeight, pegRadius);
 
 // Bottom left (Looking at circle through rectangle)
 translate([halfRectWidth - halfHullThickness, halfRectHeight - halfHullThickness, 0 ]) hexapeg(pegHeight, pegRadius);
 
 // Upper right (Looking at circle through rectangle)
 translate([(-halfRectWidth) + halfHullThickness, (-halfRectHeight) + halfHullThickness, 0 ]) hexapeg(pegHeight, pegRadius);
 
  // Upper left (Looking at circle through rectangle)
 translate([halfRectWidth - halfHullThickness, (-halfRectHeight) + halfHullThickness, 0 ]) hexapeg(pegHeight, pegRadius);
 
 // Rectangular-side flange
 translate([0,0,-flangeHeight]) difference() {
    rectangularbase(rectWidth, rectHeight, flangeHeight);
    rectangularbase(rectWidth - (hullThickness * 2), rectHeight - (hullThickness * 2), flangeHeight);
 }
 
 // Circular-side flange
 circularSideFlangeDimen = circleRadius * 2;
 translate([0, circleRadius - rectHeight/2 -rearFanDistanceAboveRectTop, -flangeHeight * 2 - extrusionHeight]) difference() {
    rectangularbase(circularSideFlangeDimen, circularSideFlangeDimen, flangeHeight);
    cylinder(r=circleRadius - hullThickness,h=flangeHeight);
    //rectangularbase(circularSideFlangeDimen - (hullThickness * 2), circularSideFlangeDimen - (hullThickness * 2), flangeHeight);
     
     // Screw holes
     // Bottom Right looking through circle at rectangle
     translate([circularFlangeScrewHoleDistance/2, circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
     
     // Bottom Left
     translate([-circularFlangeScrewHoleDistance/2, circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
     
     // Top Left
     translate([-circularFlangeScrewHoleDistance/2, -circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
     
     // Top Right
     translate([circularFlangeScrewHoleDistance/2, -circularFlangeScrewHoleDistance/2, 0]) cylinder(r=screwHoleDiameter/2 , h=flangeHeight);
 }

 
// Hull + Circular flange
translate([0,0,-flangeHeight * 2]) difference() {
    // Outer hull
    adapterHull(rectWidth, rectHeight, circleRadius, extrusionHeight, rearFanDistanceAboveRectTop, flangeHeight);

    // Inner hull
    adapterHull(rectWidth - (hullThickness * 2), rectHeight - (hullThickness * 2), circleRadius - hullThickness, extrusionHeight, rearFanDistanceAboveRectTop, flangeHeight);
}

module adapterHull(rectWidth, rectHeight, circleRadius, hullHeight, rectTopToCircleTopOffset, flangeHeight) {
    hull() {
        rectangularbase(rectWidth, rectHeight, flangeHeight);
        translate([0,circleRadius - rectHeight/2 - rectTopToCircleTopOffset, -hullHeight / 2.2]) cylinder(r=circleRadius / 1.5, height = 1);
        translate([0,circleRadius - rectHeight/2 - rectTopToCircleTopOffset, -hullHeight]) cylinder(r=circleRadius,h=flangeHeight);
    }
}

module rectangularbase(rectWidth, rectHeight, depth) {
    translate([-rectWidth/2,-rectHeight/2, 0]) cube([rectWidth, rectHeight, depth]);
}

module hexapeg(pegHeight, pegRadius) {
    linear_extrude(height = pegHeight) {
        hexagon(pegRadius,0,0);
    }
}

module hexagon(r,x,y){

polygon(points=[[(r+x),(r*(tan(30)))+y],
                [x,(r*(2/sqrt(3)))+y],
                [-r+x,(r*(tan(30)))+y],
                [-r+x,-(r*(tan(30)))+y],
                [x,-(r*(2/sqrt(3)))+y], 
                [r+x,-(r*(tan(30)))+y]]);
         
 }