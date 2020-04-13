
inner_dia = 26.6;
inner_cutout_dia = 28.3;// ????
inner_fin_dia = 29;

height = 25;
fin_width = 2;
fin_count = 6;
total_dia = 37.1;
outer_dia = 32;

notch_depth = .2;
notch_width = 1;
notch_height = 5;

difference () {
    union() {
        cylinder (h = height, d=outer_dia, center = false, $fn=100);
        for (a = [0: 360 / fin_count : 179]) {
            rotate (a) {
                translate([-total_dia / 2, -fin_width / 2, 0]) {
                    cube ([total_dia, fin_width, height]);
                }
            }
        }
    }
    // Remove the main inner cylinder
    cylinder (h = height*3, d=inner_dia, center = true, $fn=100);
    // Remove the inner fins
    for (a = [0: 360 / fin_count : 179]) {
        rotate (a) {
            translate([-inner_fin_dia / 2, -fin_width / 2, 0]) {
                cube ([inner_fin_dia, fin_width, height]);
            }
        }
    }
}

color("Blue"){
rotate(25) {translate([(inner_dia / 2)-notch_depth, 0, notch_height]) {
    cube([notch_depth, notch_width, notch_depth], center=true);
    }
}}