radix define ncl_pair_0 {
    "0" "Null" -color #5566ff,
    "1" "1" -color #5566ff,
    "2" "0" -color #5566ff,
    "3" "Invalid" -color #5566ff,
    -default default
}
radix define ncl_pair_1 {
    "0" "Null" -color #9966ff,
    "1" "1" -color #9966ff,
    "2" "0" -color #9966ff,
    "3" "Invalid" -color #9966ff, 
    -default default
}

radix define ncl_pair_2 {
    "0" "Null" -color #ff3399, 
    "1" "1" -color #ff3399, 
    "2" "0" -color #ff3399, 
    "3" "Invalid" -color #ff3399, 
    -default default
}

radix define ncl_pair_3 {
    "0" "Null" -color #ff9933, 
    "1" "1" -color #ff9933, 
    "2" "0" -color #ff9933, 
    "3" "Invalid" -color #ff9933
    -default default
}

radix define ncl_pair_4 {
    "0" "Null" -color #66ff99, 
    "1" "1" -color #66ff99, 
    "2" "0" -color #66ff99, 
    "3" "Invalid" -color #66ff99, 
    -default default
}

radix define ncl_pair_5 {
    "0" "Null" -color #33ccff, 
    "1" "1" -color #33ccff, 
    "2" "0" -color #33ccff, 
    "3" "Invalid" -color #33ccff, 
    -default default
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/Register.vhd ncl/tests/static_loop.vhd
view wave
delete wave *
vsim -gui work.static_loop

quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(0)(0).data0 & stages(0)(0).data1 )} {s00_virt}
quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(0)(1).data0 & stages(0)(1).data1 )} {s01_virt}

quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(1)(0).data0 & stages(1)(0).data1 )} {s10_virt}
quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(1)(1).data0 & stages(1)(1).data1 )} {s11_virt}

quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(2)(0).data0 & stages(2)(0).data1 )} {s20_virt}
quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(2)(1).data0 & stages(2)(1).data1 )} {s21_virt}

quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(3)(0).data0 & stages(3)(0).data1 )} {s30_virt}
quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(3)(1).data0 & stages(3)(1).data1 )} {s31_virt}

quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(4)(0).data0 & stages(4)(0).data1 )} {s40_virt}
quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(4)(1).data0 & stages(4)(1).data1 )} {s41_virt}

quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(5)(0).data0 & stages(5)(0).data1 )} {s50_virt}
quietly virtual signal -install sim:/static_loop { (context sim:/static_loop )(stages(5)(1).data0 & stages(5)(1).data1 )} {s51_virt}

add wave -noupdate -divider {Stage 0}
add wave -label {to_prev} -color #5566ff sim:/static_loop/controls(0)
add wave -label {Stage0.A} -color #5566ff -radix ncl_pair_0 sim:/static_loop/s00_virt
add wave -label {Stage0.B} -color #5566ff -radix ncl_pair_0 sim:/static_loop/s01_virt
add wave -label {from_next} -color #5566ff sim:/static_loop/controls(1)

add wave -noupdate -divider {Stage 1}
add wave -label {to_prev} -color #9966ff  sim:/static_loop/controls(1)
add wave -label {Stage1.A} -color #9966ff  -radix ncl_pair_1 sim:/static_loop/s10_virt
add wave -label {Stage1.B} -color #9966ff  -radix ncl_pair_1 sim:/static_loop/s11_virt
add wave -label {from_next} -color #9966ff  sim:/static_loop/controls(2)

add wave -noupdate -divider {Stage 2}
add wave -label {to_prev} -color #ff3399 sim:/static_loop/controls(2)
add wave -label {Stage2.A} -color #ff3399 -radix ncl_pair_2 sim:/static_loop/s20_virt
add wave -label {Stage2.B} -color #ff3399 -radix ncl_pair_2 sim:/static_loop/s21_virt
add wave -label {from_next} -color #ff3399 sim:/static_loop/controls(3)

add wave -noupdate -divider {Stage 3}
add wave -label {to_prev} -color #ff9933 sim:/static_loop/controls(3)
add wave -label {Stage3.A} -color #ff9933 -radix ncl_pair_3 sim:/static_loop/s30_virt
add wave -label {Stage3.B} -color #ff9933 -radix ncl_pair_3 sim:/static_loop/s31_virt
add wave -label {from_next} -color #ff9933 sim:/static_loop/controls(4)

add wave -noupdate -divider {Stage 4}
add wave -label {to_prev} -color #66ff99 sim:/static_loop/controls(4)
add wave -label {Stage4.A} -color #66ff99 -radix ncl_pair_4 sim:/static_loop/s40_virt
add wave -label {Stage4.B} -color #66ff99 -radix ncl_pair_4 sim:/static_loop/s41_virt
add wave -label {from_next} -color #66ff99 sim:/static_loop/controls(5)

add wave -noupdate -divider {Stage 5}
add wave -label {to_prev} -color #33ccff sim:/static_loop/controls(5)
add wave -label {Stage5.A} -color #33ccff -radix ncl_pair_5 sim:/static_loop/s50_virt
add wave -label {Stage5.B} -color #33ccff -radix ncl_pair_5 sim:/static_loop/s51_virt
add wave -label {from_next} -color #33ccff sim:/static_loop/controls(0)

configure wave -timelineunits ns

force -freeze sim:/static_loop/stages(0)(0).data0 1 0
force -freeze sim:/static_loop/stages(0)(1).data1 1 0
run 100
noforce sim:/static_loop/stages(0)(0).data0
noforce sim:/static_loop/stages(0)(1).data1

run 1000