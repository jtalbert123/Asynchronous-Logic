
radix define ncl_pair_in {
  "0" Null -color #007fff
  "1" 1 -color #007fff
  "2" 0 -color #007fff
  "3" Invalid -color #007fff
}

radix define ncl_pair_out {
  "0" Null -color #00Cf00
  "1" 1 -color #00Cf00
  "2" 0 -color #00Cf00
  "3" Invalid -color #00Cf00
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/Register.vhd ncl/components/Adder.vhd ncl/components/FullAdder.vhd ncl/tests/counter_4bit.vhd
view wave
delete wave *
vsim -gui work.Counter_4bit

quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (output(0).data0 & output(0).data1)} {o0}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (output(1).data0 & output(1).data1)} {o1}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (output(2).data0 & output(2).data1)} {o2}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (output(3).data0 & output(3).data1)} {o3}

quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iC.data0 & iC.data1)} {iC_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iA(0).data0 & iA(0).data1)} {iA0_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iA(1).data0 & iA(1).data1)} {iA1_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iA(2).data0 & iA(2).data1)} {iA2_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iA(3).data0 & iA(3).data1)} {iA3_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iB(0).data0 & iB(0).data1)} {iB0_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iB(1).data0 & iB(1).data1)} {iB1_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iB(2).data0 & iB(2).data1)} {iB2_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (iB(3).data0 & iB(3).data1)} {iB3_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (oS(0).data0 & oS(0).data1)} {oS0_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (oS(1).data0 & oS(1).data1)} {oS1_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (oS(2).data0 & oS(2).data1)} {oS2_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (oS(3).data0 & oS(3).data1)} {oS3_virt}
quietly virtual signal -install sim:/counter_4bit/counter {(context sim:/counter_4bit/counter) (oC.data0 & oC.data1)} {oC_virt}

quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(0)(0).data0 & stage_inputs(0)(0).data1)} {s00}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(0)(1).data0 & stage_inputs(0)(1).data1)} {s01}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(0)(2).data0 & stage_inputs(0)(2).data1)} {s02}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(0)(3).data0 & stage_inputs(0)(3).data1)} {s03}

quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(1)(0).data0 & stage_inputs(1)(0).data1)} {s10}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(1)(1).data0 & stage_inputs(1)(1).data1)} {s11}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(1)(2).data0 & stage_inputs(1)(2).data1)} {s12}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(1)(3).data0 & stage_inputs(1)(3).data1)} {s13}

quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(2)(0).data0 & stage_inputs(2)(0).data1)} {s20}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(2)(1).data0 & stage_inputs(2)(1).data1)} {s21}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(2)(2).data0 & stage_inputs(2)(2).data1)} {s22}
quietly virtual signal -install sim:/counter_4bit {(context sim:/counter_4bit) (stage_inputs(2)(3).data0 & stage_inputs(2)(3).data1)} {s23}

add wave -label {output(0)}  -radix ncl_pair_out sim:/counter_4bit/o0
add wave -label {output(1)}  -radix ncl_pair_out sim:/counter_4bit/o1
add wave -label {output(2)}  -radix ncl_pair_out sim:/counter_4bit/o2
add wave -label {output(3)}  -radix ncl_pair_out sim:/counter_4bit/o3

add wave -divider {stage 0}
add wave -label {from_next} sim:/counter_4bit/stage0/from_next
add wave -label {stage(0)(0)}  -radix ncl_pair_out sim:/counter_4bit/s00
add wave -label {stage(0)(1)}  -radix ncl_pair_out sim:/counter_4bit/s01
add wave -label {stage(0)(2)}  -radix ncl_pair_out sim:/counter_4bit/s02
add wave -label {stage(0)(3)}  -radix ncl_pair_out sim:/counter_4bit/s03
add wave -label {to_prev} sim:/counter_4bit/stage0/to_prev

add wave -divider {counter}
add wave -label {carries} sim:/counter_4bit/counter/carries
add wave -label {iC}  -radix ncl_pair_out sim:/counter_4bit/counter/iC_virt
add wave -group {iA} -label {iA0}  -radix ncl_pair_out sim:/counter_4bit/counter/iA0_virt
add wave -group {iA} -label {iA2}  -radix ncl_pair_out sim:/counter_4bit/counter/iA2_virt
add wave -group {iA} -label {iA3}  -radix ncl_pair_out sim:/counter_4bit/counter/iA3_virt
add wave -group {iB} -label {iB0}  -radix ncl_pair_out sim:/counter_4bit/counter/iB0_virt
add wave -group {iB} -label {iB1}  -radix ncl_pair_out sim:/counter_4bit/counter/iB1_virt
add wave -group {iB} -label {iB2}  -radix ncl_pair_out sim:/counter_4bit/counter/iB2_virt
add wave -group {iB} -label {iB3}  -radix ncl_pair_out sim:/counter_4bit/counter/iB3_virt
add wave -group {oS} -label {oS0}  -radix ncl_pair_out sim:/counter_4bit/counter/oS0_virt
add wave -group {oS} -label {oS1}  -radix ncl_pair_out sim:/counter_4bit/counter/oS1_virt
add wave -group {oS} -label {oS2}  -radix ncl_pair_out sim:/counter_4bit/counter/oS2_virt
add wave -group {oS} -label {oS3}  -radix ncl_pair_out sim:/counter_4bit/counter/oS3_virt
add wave -label {oC}  -radix ncl_pair_out sim:/counter_4bit/counter/oC_virt

add wave -divider {stage 1}
add wave -label {from_next} sim:/counter_4bit/stage1/from_next
add wave -label {stage(1)(0)}  -radix ncl_pair_out sim:/counter_4bit/s10
add wave -label {stage(1)(1)}  -radix ncl_pair_out sim:/counter_4bit/s11
add wave -label {stage(1)(2)}  -radix ncl_pair_out sim:/counter_4bit/s12
add wave -label {stage(1)(3)}  -radix ncl_pair_out sim:/counter_4bit/s13
add wave -label {to_prev} sim:/counter_4bit/stage1/to_prev

add wave -divider {stage 2}
add wave -label {from_next} sim:/counter_4bit/stage2/from_next
add wave -label {stage(2)(0)}  -radix ncl_pair_out sim:/counter_4bit/s20
add wave -label {stage(2)(1)}  -radix ncl_pair_out sim:/counter_4bit/s21
add wave -label {stage(2)(2)}  -radix ncl_pair_out sim:/counter_4bit/s22
add wave -label {stage(2)(3)}  -radix ncl_pair_out sim:/counter_4bit/s23
add wave -label {to_prev} sim:/counter_4bit/stage2/to_prev

add wave -position end  sim:/counter_4bit/links

force -freeze sim:/counter_4bit/stage_inputs(0)(0).data0 1 0 -cancel 40
force -freeze sim:/counter_4bit/stage_inputs(0)(0).data1 0 0 -cancel 40
force -freeze sim:/counter_4bit/stage_inputs(0)(1).data0 1 0 -cancel 40
force -freeze sim:/counter_4bit/stage_inputs(0)(1).data1 0 0 -cancel 40
force -freeze sim:/counter_4bit/stage_inputs(0)(2).data0 1 0 -cancel 40
force -freeze sim:/counter_4bit/stage_inputs(0)(2).data1 0 0 -cancel 40
force -freeze sim:/counter_4bit/stage_inputs(0)(3).data0 1 0 -cancel 40
force -freeze sim:/counter_4bit/stage_inputs(0)(3).data1 0 0 -cancel 40
