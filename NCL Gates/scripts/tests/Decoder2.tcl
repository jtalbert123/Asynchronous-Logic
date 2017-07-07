set input_color #007fff
set output_color #00Cf00

radix define ncl_pair_in {
  "0" Null -color #007fff
  "1" 1 -color #007fff
  "2" 0 -color #007fff
  "3" Invalid -color #007fff
}

radix define raw_ncl_pair_in {
  "0 0" Null -color #007fff
  "1 0" 1 -color #007fff
  "0 1" 0 -color #007fff
  "1 1" Invalid -color #007fff
}

radix define ncl_pair_out {
  "0" Null -color #00Cf00
  "1" 1 -color #00Cf00
  "2" 0 -color #00Cf00
  "3" Invalid -color #00Cf00
}

proc clear { } {
  noforce sim:/Decoder2_tb/iA.DATA0
  noforce sim:/Decoder2_tb/iA.DATA1
  noforce sim:/Decoder2_tb/iB.DATA0
  noforce sim:/Decoder2_tb/iB.DATA1
  noforce sim:/Decoder2_tb/iSel.DATA0
  noforce sim:/Decoder2_tb/iSel.DATA1
}

proc set_inputs_now {A B} {
  force -freeze sim:/Decoder2_tb/iA.DATA1 $A 0
  force -freeze sim:/Decoder2_tb/iA.DATA0 [expr 1-$A] 0
  run 0;
  
  force -freeze sim:/Decoder2_tb/iB.DATA1 $B 0
  force -freeze sim:/Decoder2_tb/iB.DATA0 [expr 1-$B] 0
  run 0;
  
}

proc null_inputs_now {} {
  force -freeze sim:/Decoder2_tb/iA.DATA1 0 0
  force -freeze sim:/Decoder2_tb/iA.DATA0 0 0
  run 0;

  force -freeze sim:/Decoder2_tb/iB.DATA1 0 0
  force -freeze sim:/Decoder2_tb/iB.DATA0 0 0
  run 0;
}

proc set_inputs {A B} {
  force -freeze sim:/Decoder2_tb/iA.DATA1 $A [expr round(rand()*5)]
  force -freeze sim:/Decoder2_tb/iA.DATA0 [expr 1-$A] [expr round(rand()*5)]
  run 0;
  
  force -freeze sim:/Decoder2_tb/iB.DATA1 $B [expr round(rand()*5)]
  force -freeze sim:/Decoder2_tb/iB.DATA0 [expr 1-$B] [expr round(rand()*5)]
  run 0;
}

proc null_inputs {} {
  force -freeze sim:/Decoder2_tb/iA.DATA1 0 [expr round(rand()*5)]
  force -freeze sim:/Decoder2_tb/iA.DATA0 0 [expr round(rand()*5)]
  run 0;

  force -freeze sim:/Decoder2_tb/iB.DATA1 0 [expr round(rand()*5)]
  force -freeze sim:/Decoder2_tb/iB.DATA0 0 [expr round(rand()*5)]
  run 0;
}

proc check { expected runtime } {
  set outstate [examine sim:/Decoder2_tb/output_virt]
  if {$outstate != $expected} {
    puts "Time: $runtime. Expected $expected, got $outstate";
  }
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/Decoder.vhd ncl/components/Register.vhd ncl/tests/Decoder2_tb.vhd
view wave
delete wave *
vsim -quiet work.Decoder2_tb

quietly virtual signal -install sim:/Decoder2_tb { (context sim:/Decoder2_tb )(iA.data0 & iA.data1 )} {iA_virt}
quietly virtual signal -install sim:/Decoder2_tb { (context sim:/Decoder2_tb )(iB.data0 & iB.data1 )} {iB_virt}
quietly virtual signal -install sim:/Decoder2_tb { (context sim:/Decoder2_tb )(output(0).data0 & output(0).data1 )} {output0_virt}
quietly virtual signal -install sim:/Decoder2_tb { (context sim:/Decoder2_tb )(output(1).data0 & output(1).data1 )} {output1_virt}
quietly virtual signal -install sim:/Decoder2_tb { (context sim:/Decoder2_tb )(output(2).data0 & output(2).data1 )} {output2_virt}
quietly virtual signal -install sim:/Decoder2_tb { (context sim:/Decoder2_tb )(output(3).data0 & output(3).data1 )} {output3_virt}

add wave -divider "Inputs"
add wave -radix ncl_pair_in -label "Input A" -color $input_color sim:/Decoder2_tb/iA_virt
add wave -radix ncl_pair_in -label "Input B" -color $input_color sim:/Decoder2_tb/iB_virt

add wave -divider "Outputs"
add wave -radix ncl_pair_out -label "Output 0" -color $input_color sim:/Decoder2_tb/output0_virt
add wave -radix ncl_pair_out -label "Output 1" -color $input_color sim:/Decoder2_tb/output1_virt
add wave -radix ncl_pair_out -label "Output 2" -color $input_color sim:/Decoder2_tb/output2_virt
add wave -radix ncl_pair_out -label "Output 3" -color $input_color sim:/Decoder2_tb/output3_virt
null_inputs_now
#run 50
set expected 0
for {set B 0} {$B <= 1} {incr B} {
  for {set A 0} {$A <= 1} {incr A} {
    null_inputs
    run 10;
    while {[examine sim:/Decoder2_tb/to_prev] != 1} { run 1; }
    set_inputs $A $B
    run 10;
    while {[examine sim:/Decoder2_tb/to_prev] != 0} { run 1; }
  }
}

run 80