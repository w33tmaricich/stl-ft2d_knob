$fn = 100;




// h = height in mm
// w = width in diameter in mm

h_full = 12.28;
h_ridge = 1.24;
h_grip = h_full-h_ridge;

w_top = 11.24;
w_base = 12.98;
w_ridge = 10.88;

w_open = 4.18;
w_short_open = 3.8;
h_chop_open = 3.56; //3.36?

open_depth = 10;

open_chop_missing = 0.38;

grip_gap = 1.94;
gap_margin = 3;
gap_depth = 4;

num_gaps = 10;


module gap(rotation) {
    rotate([0, 0, rotation]) translate([0,w_base/2+gap_depth,h_grip/2 + gap_margin]) cube([grip_gap, h_grip, h_grip], center=true);
}

module grip(num) {
    gap_sub = 360/num;
    difference() {
        translate([0,0,h_full/2]) cylinder(h=h_grip, r1=w_base/2, r2=w_top/2, center=true);
        for (g = [0:gap_sub:360])
            gap(g);
    }
}

module ridge(sub) {
    cylinder(h=h_ridge, r=w_ridge/2-sub, center=true);
}

module opening() {
    difference() {
        cylinder(h=open_depth, r=w_open/2, center=true);
        translate([w_open-open_chop_missing,0,0]) cube([w_open, w_open, open_depth], center = true);
    }
}

module ft2d_cap() {
    difference() {
        union() {
            grip(num_gaps);
            ridge(0);
            translate([0,0, h_full-(h_ridge/2)]) ridge(1);
        }
        opening();
    }
}

ft2d_cap();