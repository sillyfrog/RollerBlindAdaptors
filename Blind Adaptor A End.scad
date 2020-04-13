$fn=100;

inner_dia = 26.7;
inner_fin_dia = 29;

flange_dia = 30;
flange_height = 1;
flange_extra = 2;

height = 7;
fin_width = 2;
fin_count = 6;
blind_fin_dia = 28.8;
blind_fin_width = 2.5;
blind_big_fin_width = 9;
outer_dia = 35.7;

notch_depth = .2;
notch_width = 1;
notch_height = 5;

// Flange
difference () {
    cylinder (h = flange_height, d=outer_dia + flange_extra * 2, center = false);
    translate([0,0,-.1]) cylinder (h = height, d=flange_dia, center = false);
}
translate([0,0,flange_height]) {
difference () {
    union() {
        cylinder (h = height, d=outer_dia, center = false);
    }
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
        // Remove the blind big fins
    for (a = [0: 360 / 2: 360-1]) {
        rotate (a) {
            difference() {
                translate([0, -blind_big_fin_width/ 2, -.1]) {
                    cube ([outer_dia, blind_big_fin_width, height+.2]);
                }
                cylinder (h = height, d=blind_fin_dia, center = false);
            }
        }
    }

    // Remove the motor inner fins
    for (a = [360 / fin_count/2: 360 / fin_count : 179]) {
        rotate (a) {
            translate([-inner_fin_dia / 2, -fin_width / 2, -.1]) {
                cube ([inner_fin_dia, fin_width, height+.2]);
            }
        }
    }
}}

color("Blue"){
rotate(25) {translate([(inner_dia / 2)-notch_depth, 0, notch_height]) {
    cube([notch_depth, notch_width, notch_depth], center=true);
    }
}}