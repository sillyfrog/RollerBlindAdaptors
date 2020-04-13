
// Comment out follwing line for main bit (inner)
END_BIT = true;

inner_dia = 26.6;
inner_fin_dia = 29;

flange_dia = 30;
flange_height = 1;
flange_extra = 2;

fin_width = 2;
fin_count = 6;
blind_fin_dia = 28.8;
// blind_fin_width = 2.5;
blind_fin_width = 6;
// blind_big_fin_width = 9;
blind_big_fin_width1 = 17.5;
blind_big_fin_width2 = 10;
outer_dia = 36.3;

notch_depth = .2;
notch_width = 1;
notch_height = 16;

$fn=100;

if (END_BIT == undef){
    mainbit(25);
    // notch to hold in place
    color("Blue"){
        rotate(220) {translate([(inner_dia / 2)-notch_depth, 0, notch_height]) {
            cube([notch_depth, notch_width, notch_depth], center=true);
    }
}}
}

if (END_BIT == true) {
    height=7;
    // Flange
    difference () {
        cylinder (h = flange_height, d=outer_dia + flange_extra * 2, center = false);
        translate([0,0,-.1]) cylinder (h = height, d=flange_dia, center = false);
    }
    translate([0,0,flange_height]) mainbit(height);
}

module mainbit(height){
difference () {
    cylinder (h = height, d=outer_dia, center = false);
    // Remove the main inner cylinder
    cylinder (h = height*3, d=inner_dia, center = true);
    // Remove the blind fins
    for (a = [0: 360 / fin_count : 360-1]) {
        rotate (a) {
            difference() {
                translate([0, -blind_fin_width/ 2, -.1]) {
                    cube ([outer_dia, blind_fin_width, height+.2]);
                }
                cylinder (h = height, d=blind_fin_dia, center = false);
            }
        }
    }

    // Remove the motor inner fins
    difference() {
        union() {
            for (a = [360 / fin_count/2: 360 / fin_count : 179]) {
                rotate (a) {
                    translate([-inner_fin_dia / 2, -fin_width / 2, -.1]) {
                        cube ([inner_fin_dia, fin_width, height+.2]);
                    }
                }
            }
        }
        // Put in an end stop to prevent motor pushing past insert
        translate([0, 0, notch_height]) cylinder(d=inner_fin_dia, h=1); 
        // And the big bit from the stop
    }

    // Remove the blind big fins
    bigfin(0, blind_big_fin_width1, height, blind_fin_dia);
    bigfin(180, blind_big_fin_width2, height, blind_fin_dia);

    // Remove the "leftover" bit on the big side
    cutout = 15.5;
    translate([0, -cutout/2, -.1]) cube([outer_dia, cutout, height+.2]);
}
}

module bigfin(angle, width, height, innerd) {
    rotate (angle) {
        difference() {
            translate([0, -width/ 2, -.1]) {
                cube ([outer_dia, width, height+.2]);
            }
            cylinder (h = height, d=innerd, center = false);
        }
    }
}