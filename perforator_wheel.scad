//chr0 = [[0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0]]
//        
//chr1 = [[0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0]]
//         
//chr_2 = [[0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0]]
//         
//chr_3 = [[0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0],
//         [0, 0, 1, 0, 0, 0]]
//         
//chrs = [chr_0, chr_1, chr_3]

$fn=64;

height = 10;
inner_radius = 40;
outer_radius = 50;
divot_radius = 0.5;
pinhole_radius = 1.0;
grid_start_height = 3;
keyhole_offset_angle = 20;
keyhole_radius = 1.2;
keyhole_height = 5;

module rotate_about_pt(a, v, pt) {
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}

module divot(i, j ,k) {
    angle = i*36 + 2*k;
    rotate([0, 0, angle]) {
        translate([0, outer_radius, j+grid_start_height]) {
            sphere(divot_radius);
        }
    }
}

module keyhole(i) {
    angle = i*36 + keyhole_offset_angle;
    rotate([0, 0, angle]) {
        translate([0, outer_radius + 5, keyhole_height]) {
            rotate([90, 0, 0]) {
                cylinder(outer_radius - inner_radius +10, keyhole_radius, keyhole_radius);
            }
        }
    }
}

difference() {
    difference() {
        cylinder(height, outer_radius, outer_radius);
        translate([0, 0, -5]) {
            cylinder(height + 10, inner_radius, inner_radius);
        }
    }
    union() {
        for (i = [0:10]) {
            for (j = [0:3]) {
                for (k = [0:6]) {
                    divot(i, j, k);
                    keyhole(i);
                }
            }
        }
    }
} 