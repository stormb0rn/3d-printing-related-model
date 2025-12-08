// ============================================================
// 桌下电源支架 - 全部版本合集
// Desk Power Mount - All Versions Collection
// ============================================================
//
// 项目说明：
// 这是一个桌底电源/充电器固定板的参数化设计，用于将充电器或电源
// 固定在书桌底部。经过9个版本的迭代，从简单矩形板逐步优化为
// 高效的蜂窝结构设计。
//
// 使用方法：
// 在下方取消注释你想要渲染的版本，然后按 F6 渲染并导出 STL。
//
// 核心规格（所有版本通用）：
// - 螺丝孔距：120mm x 40mm（对应桌底预留孔位）
// - 螺丝规格：M6 沉头螺丝
// - 材料建议：PLA 或 PETG
//
// ============================================================

// 取消注释以下某一行来选择版本：
// version = 1;  // 基础矩形板
// version = 2;  // 改进尺寸设置
// version = 3;  // 骨架结构
// version = 4;  // 超薄版本 3mm
// version = 5;  // 跑道形设计
// version = 6;  // 十字形大承托板
// version = 7;  // 六边形蜂窝 + 应力通道
// version = 8;  // 智能挖孔
version = 9;  // 最终版本（推荐）

// ============================================================
// 版本说明
// ============================================================
//
// v1 - 基础矩形板
//      特点：简单的方形板 + 圆形减重孔
//      厚度：5mm | 文件大小：2.2MB | 渲染：1:08
//
// v2 - 改进尺寸设置
//      特点：板子尺寸与孔位分离，可独立调整
//      厚度：5mm | 文件大小：1.3MB | 渲染：0:41
//
// v3 - 骨架结构
//      特点：四角基座 + 连接梁，省料
//      厚度：5mm | 文件大小：940KB | 渲染：0:36
//
// v4 - 超薄版本
//      特点：极限薄度设计，最大化省料
//      厚度：3mm | 文件大小：1.2MB | 渲染：0:55
//
// v5 - 跑道形设计
//      特点：左右跑道形安装块 + 中间矩形连接
//      厚度：5mm | 文件大小：955KB | 渲染：0:28
//
// v6 - 十字形大承托板
//      特点：90x150mm 中间平台 + 两侧安装耳
//      厚度：5mm | 文件大小：2.1MB | 渲染：1:51
//
// v7 - 六边形蜂窝 + 应力通道
//      特点：真正的六边形孔，添加应力分散通道
//      厚度：3.2mm | 文件大小：410KB | 渲染：0:22
//
// v8 - 智能挖孔
//      特点：边框保护，避免蜂窝孔打穿边缘
//      厚度：3.2mm | 文件大小：637KB | 渲染：0:14
//
// v9 - 最终版本（推荐）
//      特点：圆角矩形 + 居中蜂窝图案，美观且高效
//      厚度：3.2mm | 文件大小：680KB | 渲染：0:26
//
// ============================================================

$fn = 30; // 圆滑度（30 足够打印用，60 更平滑但更慢）

// ============================================================
// V1 - 基础矩形板
// ============================================================
module version_1() {
    // 参数
    hole_spacing_y = 80;
    hole_spacing_x = 120;
    plate_thickness = 5;
    margin = 10;
    corner_radius = 4;
    screw_hole_dia = 6;
    countersink_top_dia = 12;
    reduce_pattern_dia = 8;
    reduce_pattern_gap = 4;

    total_width = hole_spacing_x + (margin * 2);
    total_depth = hole_spacing_y + (margin * 2);

    difference() {
        hull() {
            translate([-(total_width/2)+corner_radius, -(total_depth/2)+corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
            translate([(total_width/2)-corner_radius, -(total_depth/2)+corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
            translate([-(total_width/2)+corner_radius, (total_depth/2)-corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
            translate([(total_width/2)-corner_radius, (total_depth/2)-corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
        }

        for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
            for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                translate([x, y, -1])
                    cylinder(d=screw_hole_dia, h=plate_thickness + 2);
                translate([x, y, plate_thickness - (screw_hole_dia/2)])
                    cylinder(d1=screw_hole_dia, d2=countersink_top_dia, h=(screw_hole_dia/2)+0.1);
            }
        }

        intersection() {
            cube([hole_spacing_x - 15, hole_spacing_y - 15, 50], center=true);
            union() {
                for (x_pos = [-total_width/2 : reduce_pattern_dia+reduce_pattern_gap : total_width/2]) {
                    for (y_pos = [-total_depth/2 : reduce_pattern_dia+reduce_pattern_gap : total_depth/2]) {
                        translate([x_pos + (y_pos%2 * (reduce_pattern_dia/2)), y_pos, -1])
                            cylinder(d=reduce_pattern_dia, h=plate_thickness + 2);
                    }
                }
            }
        }
    }
}

// ============================================================
// V2 - 改进尺寸设置（板子尺寸与孔位分离）
// ============================================================
module version_2() {
    total_width_y = 80;
    total_length_x = 140;
    plate_thickness = 5;
    hole_spacing_y = 40;
    hole_spacing_x = 120;
    corner_radius = 4;
    screw_hole_dia = 6;
    countersink_top_dia = 12;
    reduce_pattern_dia = 8;
    reduce_pattern_gap = 4;

    difference() {
        hull() {
            translate([-(total_length_x/2)+corner_radius, -(total_width_y/2)+corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
            translate([(total_length_x/2)-corner_radius, -(total_width_y/2)+corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
            translate([-(total_length_x/2)+corner_radius, (total_width_y/2)-corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
            translate([(total_length_x/2)-corner_radius, (total_width_y/2)-corner_radius, 0])
                cylinder(r=corner_radius, h=plate_thickness);
        }

        for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
            for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                translate([x, y, -1])
                    cylinder(d=screw_hole_dia, h=plate_thickness + 2);
                translate([x, y, plate_thickness - (screw_hole_dia/2)])
                    cylinder(d1=screw_hole_dia, d2=countersink_top_dia, h=(screw_hole_dia/2)+0.1);
            }
        }

        intersection() {
            difference() {
                cube([total_length_x - 10, total_width_y - 10, 50], center=true);
                for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
                    for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                        translate([x, y, 0])
                            cylinder(r=countersink_top_dia/2 + 4, h=100, center=true);
                    }
                }
            }
            union() {
                for (x_pos = [-total_length_x/2 : reduce_pattern_dia+reduce_pattern_gap : total_length_x/2]) {
                    for (y_pos = [-total_width_y/2 : reduce_pattern_dia+reduce_pattern_gap : total_width_y/2]) {
                        translate([x_pos + (y_pos%2 * (reduce_pattern_dia/2)), y_pos, -1])
                            cylinder(d=reduce_pattern_dia, h=plate_thickness + 2);
                    }
                }
            }
        }
    }
}

// ============================================================
// V3 - 骨架结构（四角基座 + 连接梁）
// ============================================================
module version_3() {
    hole_spacing_y = 40;
    hole_spacing_x = 120;
    plate_thickness = 5;
    mount_radius = 8;
    screw_hole_dia = 6;
    countersink_top_dia = 12;
    reduce_pattern_dia = 6;
    reduce_pattern_gap = 3;

    difference() {
        union() {
            for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
                for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                    translate([x, y, 0])
                        cylinder(r=mount_radius, h=plate_thickness);
                }
            }
            for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                hull() {
                    translate([-hole_spacing_x/2, y, 0]) cylinder(r=mount_radius, h=plate_thickness);
                    translate([hole_spacing_x/2, y, 0]) cylinder(r=mount_radius, h=plate_thickness);
                }
            }
            hull() {
                for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
                    for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                        translate([x, y, 0])
                            cylinder(r=mount_radius, h=plate_thickness);
                    }
                }
            }
        }

        for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
            for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                translate([x, y, -1])
                    cylinder(d=screw_hole_dia, h=plate_thickness + 2);
                translate([x, y, plate_thickness - (screw_hole_dia/2)])
                    cylinder(d1=screw_hole_dia, d2=countersink_top_dia, h=(screw_hole_dia/2)+0.1);
            }
        }

        intersection() {
            cube([hole_spacing_x - mount_radius*2, hole_spacing_y - mount_radius*1.5, 50], center=true);
            union() {
                for (x_pos = [-hole_spacing_x/2 : reduce_pattern_dia+reduce_pattern_gap : hole_spacing_x/2]) {
                    for (y_pos = [-hole_spacing_y/2 : reduce_pattern_dia+reduce_pattern_gap : hole_spacing_y/2]) {
                        translate([x_pos + (y_pos%2 * (reduce_pattern_dia/2)), y_pos, -1])
                            cylinder(d=reduce_pattern_dia, h=plate_thickness + 2);
                    }
                }
            }
        }
    }
}

// ============================================================
// V4 - 超薄版本（3mm 极限厚度）
// ============================================================
module version_4() {
    plate_thickness = 3;
    hole_spacing_y = 40;
    hole_spacing_x = 120;
    mount_radius = 7;
    screw_hole_dia = 6;
    reduce_pattern_dia = 5;
    reduce_pattern_gap = 3;

    difference() {
        union() {
            for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
                for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                    translate([x, y, 0])
                        cylinder(r=mount_radius, h=plate_thickness);
                }
            }
            hull() {
                for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
                    for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                        translate([x, y, 0])
                            cylinder(r=mount_radius, h=plate_thickness);
                    }
                }
            }
        }

        for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
            for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                translate([x, y, -1])
                    cylinder(d=screw_hole_dia, h=plate_thickness + 2);
                translate([x, y, plate_thickness - 3.5])
                    cylinder(d1=screw_hole_dia, d2=13, h=3.6);
            }
        }

        intersection() {
            cube([hole_spacing_x - mount_radius*2, hole_spacing_y - mount_radius, 50], center=true);
            union() {
                for (x_pos = [-hole_spacing_x/2 : reduce_pattern_dia+reduce_pattern_gap : hole_spacing_x/2]) {
                    for (y_pos = [-hole_spacing_y/2 : reduce_pattern_dia+reduce_pattern_gap : hole_spacing_y/2]) {
                        translate([x_pos + (y_pos%2 * (reduce_pattern_dia/2)), y_pos, -1])
                            cylinder(d=reduce_pattern_dia, h=plate_thickness + 2);
                    }
                }
            }
        }
    }
}

// ============================================================
// V5 - 跑道形设计
// ============================================================
module version_5() {
    hole_spacing_y = 40;
    hole_spacing_x = 120;
    plate_thickness = 5;
    screw_hole_dia = 6;
    countersink_top_dia = 12;
    mount_radius = 8;
    connect_plate_wid = hole_spacing_y;
    reduce_pattern_dia = 6;
    reduce_pattern_gap = 4;

    difference() {
        union() {
            hull() {
                translate([-hole_spacing_x/2, -hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
                translate([-hole_spacing_x/2, hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
            }
            hull() {
                translate([hole_spacing_x/2, -hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
                translate([hole_spacing_x/2, hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
            }
            translate([0, 0, plate_thickness/2])
                cube([hole_spacing_x, connect_plate_wid, plate_thickness], center=true);
        }

        for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
            for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                translate([x, y, -1])
                    cylinder(d=screw_hole_dia, h=plate_thickness + 2);
                translate([x, y, plate_thickness - (screw_hole_dia/2)])
                    cylinder(d1=screw_hole_dia, d2=countersink_top_dia, h=(screw_hole_dia/2)+0.1);
            }
        }

        intersection() {
            hole_area_length = hole_spacing_x - mount_radius*2;
            hole_area_width = connect_plate_wid - 4;
            cube([hole_area_length, hole_area_width, 50], center=true);
            union() {
                for (x_pos = [-hole_spacing_x/2 : reduce_pattern_dia+reduce_pattern_gap : hole_spacing_x/2]) {
                    for (y_pos = [-hole_spacing_y/2 : reduce_pattern_dia+reduce_pattern_gap : hole_spacing_y/2]) {
                        translate([x_pos + (y_pos%2 * (reduce_pattern_dia/2)), y_pos, -1])
                            cylinder(d=reduce_pattern_dia, h=plate_thickness + 2);
                    }
                }
            }
        }
    }
}

// ============================================================
// V6 - 十字形大承托板（90x150mm 平台）
// ============================================================
module version_6() {
    center_plate_width = 90;
    center_plate_length = 150;
    hole_spacing_x = 120;
    hole_spacing_y = 40;
    plate_thickness = 5;
    screw_hole_dia = 6;
    countersink_top_dia = 12;
    mount_radius = 8;
    reduce_pattern_dia = 8;
    reduce_pattern_gap = 4;

    difference() {
        union() {
            translate([0, 0, plate_thickness/2])
                cube([center_plate_width, center_plate_length, plate_thickness], center=true);
            hull() {
                translate([-hole_spacing_x/2, -hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
                translate([-hole_spacing_x/2, hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
                translate([-center_plate_width/2 + 5, 0, plate_thickness/2])
                    cube([10, 20, plate_thickness], center=true);
            }
            hull() {
                translate([hole_spacing_x/2, -hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
                translate([hole_spacing_x/2, hole_spacing_y/2, 0])
                    cylinder(r=mount_radius, h=plate_thickness);
                translate([center_plate_width/2 - 5, 0, plate_thickness/2])
                    cube([10, 20, plate_thickness], center=true);
            }
        }

        for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
            for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                translate([x, y, -1])
                    cylinder(d=screw_hole_dia, h=plate_thickness + 2);
                translate([x, y, plate_thickness - (screw_hole_dia/2)])
                    cylinder(d1=screw_hole_dia, d2=countersink_top_dia, h=(screw_hole_dia/2)+0.1);
            }
        }

        intersection() {
            union() {
                cube([center_plate_width-4, center_plate_length-4, 100], center=true);
                cube([hole_spacing_x, hole_spacing_y, 100], center=true);
            }
            difference() {
                cube([200, 200, 50], center=true);
                for (x = [-hole_spacing_x/2, hole_spacing_x/2]) {
                    for (y = [-hole_spacing_y/2, hole_spacing_y/2]) {
                        translate([x, y, 0])
                            cylinder(r=mount_radius + 2, h=100, center=true);
                    }
                }
            }
            union() {
                for (x_pos = [-center_plate_width : reduce_pattern_dia+reduce_pattern_gap : center_plate_width]) {
                    for (y_pos = [-center_plate_length/2 : reduce_pattern_dia+reduce_pattern_gap : center_plate_length/2]) {
                        translate([x_pos + (y_pos%2 * (reduce_pattern_dia/2)), y_pos, -1])
                            cylinder(d=reduce_pattern_dia, h=plate_thickness + 2);
                    }
                }
            }
        }
    }
}

// ============================================================
// V7 - 六边形蜂窝 + 应力通道
// ============================================================
module version_7() {
    center_w = 90;
    center_l = 150;
    hole_dx = 120;
    hole_dy = 40;
    thickness = 3.2;
    solid_radius = 12;
    rib_width = 1.6;
    screw_d = 6;
    c_sink_d = 12;
    hex_size = 10;

    difference() {
        union() {
            translate([-center_w/2, -center_l/2, 0])
                cube([center_w, center_l, thickness]);
            hull() {
                translate([-hole_dx/2, hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([-hole_dx/2, -hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([-center_w/2 + 2, -hole_dy/2 - 10, 0]) cube([5, hole_dy + 20, thickness]);
            }
            hull() {
                translate([hole_dx/2, hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([hole_dx/2, -hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([center_w/2 - 7, -hole_dy/2 - 10, 0]) cube([5, hole_dy + 20, thickness]);
            }
        }

        intersection() {
            union() {
                for (x = [-100 : (hex_size*1.732 + rib_width) : 100]) {
                    for (y = [-100 : (hex_size*1.5 + rib_width/1.2) : 100]) {
                        translate([x + (abs(y)%2 * (hex_size*1.732 + rib_width)/2), y * 1.732 / 2, -1])
                            cylinder(r=hex_size/2, h=thickness+2, $fn=6);
                    }
                }
            }
            difference() {
                cube([200, 200, 50], center=true);
                union() {
                    for (cx = [-hole_dx/2, hole_dx/2]) {
                        for (cy = [-hole_dy/2, hole_dy/2]) {
                            translate([cx, cy, 0])
                                cylinder(r=solid_radius, h=100, center=true);
                            hull() {
                                translate([cx, cy, 0]) cylinder(r=8, h=100, center=true);
                                translate([0, cy/2, 0]) cylinder(r=5, h=100, center=true);
                            }
                        }
                    }
                }
            }
        }

        for (x = [-hole_dx/2, hole_dx/2]) {
            for (y = [-hole_dy/2, hole_dy/2]) {
                translate([x, y, -1])
                    cylinder(d=screw_d, h=thickness + 2);
                translate([x, y, thickness - 3.5])
                    cylinder(d1=screw_d, d2=c_sink_d, h=3.6);
            }
        }
    }
}

// ============================================================
// V8 - 智能挖孔（边框保护）
// ============================================================
module version_8() {
    center_w = 90;
    center_l = 150;
    hole_dx = 120;
    hole_dy = 40;
    thickness = 3.2;
    solid_radius = 13;
    border_margin = 3;
    rib_width = 1.6;
    screw_d = 6;
    c_sink_d = 12;
    hex_r = 5;

    step_x = hex_r * sqrt(3) + rib_width;
    step_y = hex_r * 1.5 + rib_width * sqrt(3)/2;

    difference() {
        union() {
            translate([-center_w/2, -center_l/2, 0])
                cube([center_w, center_l, thickness]);
            hull() {
                translate([-hole_dx/2, hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([-hole_dx/2, -hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([-center_w/2, -hole_dy/2 - 10, 0]) cube([2, hole_dy + 20, thickness]);
            }
            hull() {
                translate([hole_dx/2, hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([hole_dx/2, -hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([center_w/2 - 2, -hole_dy/2 - 10, 0]) cube([2, hole_dy + 20, thickness]);
            }
        }

        union() {
            for (x = [-center_w/2 : step_x : center_w/2]) {
                for (y = [-center_l/2 : step_y : center_l/2]) {
                    pos_x = x + (floor(y/step_y)%2 * step_x/2);
                    pos_y = y;

                    isInCenter = (abs(pos_x) < (center_w/2 - border_margin - hex_r)) &&
                                 (abs(pos_y) < (center_l/2 - border_margin - hex_r));

                    isOutsideSolid = true;
                    for (sx = [-hole_dx/2, hole_dx/2]) {
                        for (sy = [-hole_dy/2, hole_dy/2]) {
                            if (norm([pos_x-sx, pos_y-sy]) < (solid_radius + hex_r)) {
                                isOutsideSolid = false;
                            }
                        }
                    }

                    if (isInCenter && isOutsideSolid) {
                        translate([pos_x, pos_y, -1])
                            rotate([0,0,30])
                            cylinder(r=hex_r, h=thickness+2, $fn=6);
                    }
                }
            }
        }

        for (x = [-hole_dx/2, hole_dx/2]) {
            for (y = [-hole_dy/2, hole_dy/2]) {
                translate([x, y, -1]) cylinder(d=screw_d, h=thickness + 2);
                translate([x, y, thickness - 3.5]) cylinder(d1=screw_d, d2=c_sink_d, h=3.6);
            }
        }
    }
}

// ============================================================
// V9 - 最终版本（推荐）
// 特点：圆角矩形 + 居中蜂窝图案
// ============================================================
module version_9() {
    center_w = 90;
    center_l = 150;
    hole_dx = 120;
    hole_dy = 40;
    plate_r = 6;
    thickness = 3.2;
    hex_r = 5;
    rib_width = 1.8;
    border_margin = 4;
    screw_d = 6;
    c_sink_d = 12;

    step_x = hex_r * sqrt(3) + rib_width;
    step_y = hex_r * 1.5 + rib_width * sqrt(3)/2;
    count_x = center_w / step_x;
    count_y = center_l / step_y;

    difference() {
        union() {
            hull() {
                translate([-center_w/2 + plate_r, -center_l/2 + plate_r, 0])
                    cylinder(r=plate_r, h=thickness);
                translate([center_w/2 - plate_r, -center_l/2 + plate_r, 0])
                    cylinder(r=plate_r, h=thickness);
                translate([-center_w/2 + plate_r, center_l/2 - plate_r, 0])
                    cylinder(r=plate_r, h=thickness);
                translate([center_w/2 - plate_r, center_l/2 - plate_r, 0])
                    cylinder(r=plate_r, h=thickness);
            }
            hull() {
                translate([-hole_dx/2, hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([-hole_dx/2, -hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([-center_w/2 + 5, -hole_dy/2 - 10, 0]) cube([2, hole_dy + 20, thickness]);
            }
            hull() {
                translate([hole_dx/2, hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([hole_dx/2, -hole_dy/2, 0]) cylinder(r=10, h=thickness);
                translate([center_w/2 - 7, -hole_dy/2 - 10, 0]) cube([2, hole_dy + 20, thickness]);
            }
        }

        intersection() {
            union() {
                for (i = [-ceil(count_x/2) : ceil(count_x/2)]) {
                    for (j = [-ceil(count_y/2) : ceil(count_y/2)]) {
                        pos_x = i * step_x + (abs(j)%2 == 1 ? step_x/2 : 0);
                        pos_y = j * step_y;
                        translate([pos_x, pos_y, -1])
                            rotate([0,0,30])
                            cylinder(r=hex_r, h=thickness+2, $fn=6);
                    }
                }
            }
            hull() {
                translate([-(center_w/2 - border_margin - hex_r) + plate_r, -(center_l/2 - border_margin - hex_r) + plate_r, -2])
                    cylinder(r=plate_r, h=thickness+4);
                translate([(center_w/2 - border_margin - hex_r) - plate_r, -(center_l/2 - border_margin - hex_r) + plate_r, -2])
                    cylinder(r=plate_r, h=thickness+4);
                translate([-(center_w/2 - border_margin - hex_r) + plate_r, (center_l/2 - border_margin - hex_r) - plate_r, -2])
                    cylinder(r=plate_r, h=thickness+4);
                translate([(center_w/2 - border_margin - hex_r) - plate_r, (center_l/2 - border_margin - hex_r) - plate_r, -2])
                    cylinder(r=plate_r, h=thickness+4);
            }
        }

        for (x = [-hole_dx/2, hole_dx/2]) {
            for (y = [-hole_dy/2, hole_dy/2]) {
                translate([x, y, -1]) cylinder(d=screw_d, h=thickness + 2);
                translate([x, y, thickness - 3.5]) cylinder(d1=screw_d, d2=c_sink_d, h=3.6);
            }
        }
    }
}

// ============================================================
// 渲染选择的版本
// ============================================================
if (version == 1) version_1();
else if (version == 2) version_2();
else if (version == 3) version_3();
else if (version == 4) version_4();
else if (version == 5) version_5();
else if (version == 6) version_6();
else if (version == 7) version_7();
else if (version == 8) version_8();
else if (version == 9) version_9();
