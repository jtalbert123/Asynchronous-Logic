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
  noforce sim:/mux2_tb/iA.DATA0
  noforce sim:/mux2_tb/iA.DATA1
  noforce sim:/mux2_tb/iB.DATA0
  noforce sim:/mux2_tb/iB.DATA1
  noforce sim:/mux2_tb/iSel.DATA0
  noforce sim:/mux2_tb/iSel.DATA1
}

proc set_inputs_now {A B S} {
  
  clear
  
  force -freeze sim:/mux2_tb/iA.DATA1 $A 0
  force -freeze sim:/mux2_tb/iA.DATA0 [expr 1-$A] 0
  run 0;
  
  force -freeze sim:/mux2_tb/iB.DATA1 $B 0
  force -freeze sim:/mux2_tb/iB.DATA0 [expr 1-$B] 0
  run 0;
  
  force -freeze sim:/mux2_tb/iSel.DATA1 $S 0
  force -freeze sim:/mux2_tb/iSel.DATA0 [expr 1-$S] 0
  run 0;
  
}

proc null_inputs_now {} {
  
  clear
  
  force -freeze sim:/mux2_tb/iA.DATA1 0 0
  force -freeze sim:/mux2_tb/iA.DATA0 0 0
  run 0;

  force -freeze sim:/mux2_tb/iB.DATA1 0 0
  force -freeze sim:/mux2_tb/iB.DATA0 0 0
  run 0;

  force -freeze sim:/mux2_tb/iSel.DATA1 0 0
  force -freeze sim:/mux2_tb/iSel.DATA0 0 0
  run 0;
}

proc set_inputs {A B S} {
  
  clear
  
  force -freeze sim:/mux2_tb/iA.DATA1 $A [expr round(rand()*5)]
  force -freeze sim:/mux2_tb/iA.DATA0 [expr 1-$A] [expr round(rand()*5)]
  run 0;
  
  force -freeze sim:/mux2_tb/iB.DATA1 $B [expr round(rand()*5)]
  force -freeze sim:/mux2_tb/iB.DATA0 [expr 1-$B] [expr round(rand()*5)]
  run 0;
  
  force -freeze sim:/mux2_tb/iSel.DATA1 $S [expr round(rand()*5)]
  force -freeze sim:/mux2_tb/iSel.DATA0 [expr 1-$S] [expr round(rand()*5)]
  run 0;
}

proc null_inputs {} {
  
  clear

  force -freeze sim:/mux2_tb/iA.DATA1 0 [expr round(rand()*5)]
  force -freeze sim:/mux2_tb/iA.DATA0 0 [expr round(rand()*5)]
  run 0;

  force -freeze sim:/mux2_tb/iB.DATA1 0 [expr round(rand()*5)]
  force -freeze sim:/mux2_tb/iB.DATA0 0 [expr round(rand()*5)]
  run 0;

  force -freeze sim:/mux2_tb/iSel.DATA1 0 [expr round(rand()*5)]
  force -freeze sim:/mux2_tb/iSel.DATA0 0 [expr round(rand()*5)]
  run 0;
}

proc check { expected runtime } {
  set outstate [examine sim:/MUX2_tb/output_virt]
  if {$outstate != $expected} {
    puts "Time: $runtime. Expected $expected, got $outstate";
  }
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/MUX.vhd ncl/components/Register.vhd ncl/tests/MUX2_tb.vhd
view wave
delete wave *
vsim -quiet work.mux2_tb

quietly virtual signal -install sim:/mux2_tb { (context sim:/mux2_tb )(iA.data0 & iA.data1 )} {iA_virt}
quietly virtual signal -install sim:/mux2_tb { (context sim:/mux2_tb )(iB.data0 & iB.data1 )} {iB_virt}
quietly virtual signal -install sim:/mux2_tb { (context sim:/mux2_tb )(iSel.data0 & iSel.data1 )} {iSel_virt}
quietly virtual signal -install sim:/mux2_tb { (context sim:/mux2_tb )(output.data0 & output.data1 )} {output_virt}

add wave -divider "Inputs"
add wave -radix ncl_pair_in -label "Input A" -color $input_color sim:/mux2_tb/iA_virt
add wave -radix ncl_pair_in -label "Input B" -color $input_color sim:/mux2_tb/iB_virt
add wave -radix ncl_pair_in -label "Input Sel" -color $input_color sim:/mux2_tb/iSel_virt

add wave -divider "Outputs"
add wave -radix ncl_pair_out -label "Output" -color $input_color sim:/mux2_tb/output_virt

#add wave -divider "Internals"
#quietly virtual signal -install sim:/mux2_tb/MUX2 { (context sim:/mux2_tb/MUX2 )(iOptions(0).data0 & iOptions(0).data1 )} {Options0_virt}
#quietly virtual signal -install sim:/mux2_tb/MUX2 { (context sim:/mux2_tb/MUX2 )(iOptions(1).data0 & iOptions(1).data1 )} {Options1_virt}
#quietly virtual signal -install sim:/mux2_tb/MUX2 { (context sim:/mux2_tb/MUX2 )(output.data0 & output.data1 )} {internal_out_virt}
#add wave -radix ncl_pair_out -label "Options(0)" -color $input_color sim:/mux2_tb/MUX2/Options0_virt
#add wave -radix ncl_pair_out -label "Options(1)" -color $input_color sim:/mux2_tb/MUX2/Options1_virt
#add wave -radix ncl_pair_out -label "Output" -color $input_color sim:/mux2_tb/MUX2/internal_out_virt
#add wave sim:/mux2_tb/MUX2/*

#add wave -height 50 -divider "Internals"
#
#add wave -divider "RegBefore"
#add wave -label "in(0)" -radix ncl_pair_in -color $input_color sim:/mux2_tb/RegBefore/i0_virt
#add wave -label "in(1)" -radix ncl_pair_in -color $input_color sim:/mux2_tb/RegBefore/i1_virt
#add wave -label "in(2)" -radix ncl_pair_in -color $input_color sim:/mux2_tb/RegBefore/i2_virt
#add wave -label "out(0)" -radix ncl_pair_out -color $input_color sim:/mux2_tb/RegBefore/o0_virt
#add wave -label "out(1)" -radix ncl_pair_out -color $input_color sim:/mux2_tb/RegBefore/o1_virt
#add wave -label "out(2)" -radix ncl_pair_out -color $input_color sim:/mux2_tb/RegBefore/o2_virt
#
#add wave -divider "mux2"
#add wave -label "Cin" -radix ncl_pair_in -color $input_color sim:/mux2_tb/mux2/cin_virt
#add wave -label "A" -radix ncl_pair_in -color $input_color sim:/mux2_tb/mux2/a_virt
#add wave -label "B" -radix ncl_pair_in -color $input_color sim:/mux2_tb/mux2/b_virt
#add wave -label "Sum" -radix ncl_pair_out -color $output_color sim:/mux2_tb/mux2/sum_virt
#add wave -label "Cout" -radix ncl_pair_out -color $output_color sim:/mux2_tb/mux2/cout_virt
null_inputs_now
run 50
set expected 0
for {set A 0} {$A <= 1} {incr A} {
  for {set B 0} {$B <= 1} {incr B} {
    for {set S 0} {$S <= 1} {incr S} {
      null_inputs_now
	  while {[examine sim:/mux2_tb/to_prev] != 1} { run 1; }
	  check $expected $now
	  run 10;
	  set_inputs $A $B $S
	  set expected [expr $S ? $B : $A]
	  set_inputs_now $A $B $S
	  while {[examine sim:/mux2_tb/to_prev] != 0} { run 1; }
	  run 10;
    }
  }
}

run 100