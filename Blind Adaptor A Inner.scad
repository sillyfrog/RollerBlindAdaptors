$fn=100;

inner_dia = 26.6;
inner_fin_dia = 29;

height = 25;
fin_width = 2;
fin_count = 6;
blind_fin_dia = 28.8;
blind_fin_width = 2.5;
blind_big_fin_width = 9;
outer_dia = 36.7;

notch_depth = .2;
notch_width = 1;
notch_height = 16;

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
    }
}



color("Blue"){
rotate(25) {translate([(inner_dia / 2)-notch_depth, 0, notch_height]) {
    cube([notch_depth, notch_width, notch_depth], center=true);
    }
}}