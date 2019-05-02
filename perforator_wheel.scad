X = 1;

chr1 = [[X, X, 0], 
        [0, X, 0],
        [0, X, 0], 
        [0, X, 0],
        [0, X, 0], 
        [X, X, X]];
         
chr2 = [[X, X, X], 
        [0, 0, X],
        [0, 0, X], 
        [X, X, X],
        [X, 0, 0], 
        [X, X, X]];
         
chr3 = [[X, X, X], 
        [0, 0, X],
        [X, X, X], 
        [0, 0, X],
        [0, 0, X], 
        [X, X, X]];
        
chr4 = [[X, 0, X], 
        [X, 0, X],
        [X, 0, X], 
        [X, X, X],
        [0, 0, X], 
        [0, 0, X]];
        
chr5 = [[X, X, X], 
        [X, 0, 0],
        [X, X, 0], 
        [0, 0, X],
        [0, 0, X], 
        [X, X, 0]];
        
chr6 = [[X, X, X], 
        [X, 0, 0],
        [X, X, X], 
        [X, 0, X],
        [X, 0, X], 
        [0, X, 0]];

chr7 = [[X, X, X], 
        [0, 0, X],
        [0, 0, X], 
        [0, X, 0],
        [0, X, 0], 
        [X, 0, 0]];

chr8 = [[X, X, X], 
        [X, 0, X],
        [0, X, 0], 
        [X, 0, X],
        [X, 0, X], 
        [X, X, X]];

chr9 = [[X, X, X], 
        [X, 0, X],
        [X, 0, X], 
        [0, X, X],
        [0, 0, X], 
        [X, X, X]];
        
chr10 = [[X, X, X], 
         [X, 0, X],
         [X, 0, X], 
         [X, 0, X],
         [X, 0, X], 
         [X, X, X]];
        
chrs = [chr10, chr1, chr2, chr3, chr4,
        chr5, chr6, chr7, chr8, chr9];

$fn=64;

height = 10;
inner_radius = 40;
outer_radius = 50;
divot_radius = 0.5;
pinhole_radius = 1.0;
grid_start_height = 3;
keyhole_offset_angle = 25;
keyhole_radius = 1.2;
keyhole_height = 8;
letter_size = 5;
letter_height = 5;

module divot(i, j ,k) {
    angle = i*36 + 2*j;
    rotate([0, 0, angle]) {
        translate([0, outer_radius, k*2+grid_start_height]) {
            if (chrs[i][j][k] == 1) {
                sphere(divot_radius);
            } else {
                rotate([90, 0, 0]){
                    cylinder(5, pinhole_radius, pinhole_radius);
                }
            }
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

module number(i) {
    angle = (9-i)*36 + keyhole_offset_angle;
    rotate([0, 0, angle]) {
        translate([0, outer_radius, letter_height]) {
            rotate([90, 90, 0]) {
                linear_extrude(2){text(str(i), letter_size, halign="center", valign="center");}
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
        for (i = [0:9]) {
            for (j = [0:5]) {
                for (k = [0:2]) {
                    divot(i, j, k);
                    keyhole(i);
                    number(i);
                }
            }
        }
    }
} 