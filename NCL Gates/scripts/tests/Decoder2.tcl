set input_color #007fff
set output_color #00Cf00

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

proc clear { } {
  noforce sim:/decoder/inputs(0).DATA0
  noforce sim:/decoder/inputs(0).DATA1
  noforce sim:/decoder/inputs(1).DATA0
  noforce sim:/decoder/inputs(1).DATA1
  noforce sim:/decoder/iSel.DATA0
  noforce sim:/decoder/iSel.DATA1
}

proc set_inputs_now {A B} {
  force -freeze sim:/decoder/inputs(0).DATA1 $A 0
  force -freeze sim:/decoder/inputs(0).DATA0 [expr 1-$A] 0
  run 0;
  
  force -freeze sim:/decoder/inputs(1).DATA1 $B 0
  force -freeze sim:/decoder/inputs(1).DATA0 [expr 1-$B] 0
  run 0;
  
}

proc null_inputs_now {} {
  force -freeze sim:/decoder/inputs(0).DATA1 0 0
  force -freeze sim:/decoder/inputs(0).DATA0 0 0
  run 0;

  force -freeze sim:/decoder/inputs(1).DATA1 0 0
  force -freeze sim:/decoder/inputs(1).DATA0 0 0
  run 0;
}

proc set_inputs {A B} {
  force -freeze sim:/decoder/inputs(0).DATA1 $A [expr round(rand()*5)]
  force -freeze sim:/decoder/inputs(0).DATA0 [expr 1-$A] [expr round(rand()*5)]
  run 0;
  
  force -freeze sim:/decoder/inputs(1).DATA1 $B [expr round(rand()*5)]
  force -freeze sim:/decoder/inputs(1).DATA0 [expr 1-$B] [expr round(rand()*5)]
  run 0;
}

proc null_inputs {} {
  force -freeze sim:/decoder/inputs(0).DATA1 0 [expr round(rand()*5)]
  force -freeze sim:/decoder/inputs(0).DATA0 0 [expr round(rand()*5)]
  run 0;

  force -freeze sim:/decoder/inputs(1).DATA1 0 [expr round(rand()*5)]
  force -freeze sim:/decoder/inputs(1).DATA0 0 [expr round(rand()*5)]
  run 0;
}

proc check { expected runtime } {
  set outstate0 [examine sim:/decoder/output0_virt]
  set outstate1 [examine sim:/decoder/output1_virt]
  set outstate2 [examine sim:/decoder/output2_virt]
  set outstate3 [examine sim:/decoder/output3_virt]
  set outstate [expr $outstate0 ? 0 : ($outstate1 ? 1 : ($outstate2 ? 2 : ($outstate3 ? 3 : 0)))]
  if {$outstate != $expected} {
    puts "Time: $runtime. Expected $expected, got $outstate";
  }
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/Decoder.vhd ncl/components/Register.vhd
view wave
delete wave *
vsim -quiet work.decoder

quietly virtual signal -install sim:/decoder { (context sim:/decoder )(inputs(0).data0 & inputs(0).data1 )} {i0_virt}
quietly virtual signal -install sim:/decoder { (context sim:/decoder )(inputs(1).data0 & inputs(1).data1 )} {i1_virt}
quietly virtual signal -install sim:/decoder { (context sim:/decoder )(outputs(0).data0 & outputs(0).data1 )} {output0_virt}
quietly virtual signal -install sim:/decoder { (context sim:/decoder )(outputs(1).data0 & outputs(1).data1 )} {output1_virt}
quietly virtual signal -install sim:/decoder { (context sim:/decoder )(outputs(2).data0 & outputs(2).data1 )} {output2_virt}
quietly virtual signal -install sim:/decoder { (context sim:/decoder )(outputs(3).data0 & outputs(3).data1 )} {output3_virt}

add wave -divider "Inputs"
add wave -radix ncl_pair_in -label "Input A" -color $input_color sim:/decoder/i0_virt
add wave -radix ncl_pair_in -label "Input B" -color $input_color sim:/decoder/i1_virt

add wave -divider "Outputs"
add wave -radix ncl_pair_out -label "Output 0" -color $input_color sim:/decoder/output0_virt
add wave -radix ncl_pair_out -label "Output 1" -color $input_color sim:/decoder/output1_virt
add wave -radix ncl_pair_out -label "Output 2" -color $input_color sim:/decoder/output2_virt
add wave -radix ncl_pair_out -label "Output 3" -color $input_color sim:/decoder/output3_virt
null_inputs_now
#run 50
set expected 0
for {set B 0} {$B <= 1} {incr B} {
  for {set A 0} {$A <= 1} {incr A} {
    null_inputs
    run 50;
    set_inputs $A $B
    run 50;
    check [expr $A+$B*2] $now
  }
}

run 80