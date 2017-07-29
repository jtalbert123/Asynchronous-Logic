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

proc set_inputs_now {A B C} {
  if {$A} {
    force -drive /adder_tb/iA.DATA1 1 0
	force -drive /adder_tb/iA.DATA0 0 0
  } else {
    force -drive /adder_tb/iA.DATA1 0 0
	force -drive /adder_tb/iA.DATA0 1 0
  }
  
  if {$B} {
    force -drive /adder_tb/iB.DATA1 1 0
	force -drive /adder_tb/iB.DATA0 0 0
  } else {
    force -drive /adder_tb/iB.DATA1 0 0
	force -drive /adder_tb/iB.DATA0 1 0
  }
  
  if {$C} {
    force -drive /adder_tb/iC.DATA1 1 0
	force -drive /adder_tb/iC.DATA0 0 0
  } else {
    force -drive /adder_tb/iC.DATA1 0 0
	force -drive /adder_tb/iC.DATA0 1 0
  }
}

proc null_inputs_now {} {
    force -drive /adder_tb/iA.DATA1 0 0
	force -drive /adder_tb/iA.DATA0 0 0
	
    force -drive /adder_tb/iB.DATA1 0 0
	force -drive /adder_tb/iB.DATA0 0 0
	
    force -drive /adder_tb/iC.DATA1 0 0
	force -drive /adder_tb/iC.DATA0 0 0
}

proc set_inputs {A B C} {
  if {$A} {
    force -drive /adder_tb/iA.DATA1 1 [expr round(rand()*5)]
	force -drive /adder_tb/iA.DATA0 0 [expr round(rand()*5)]
  } else {
    force -drive /adder_tb/iA.DATA1 0 [expr round(rand()*5)]
	force -drive /adder_tb/iA.DATA0 1 [expr round(rand()*5)]
  }
  
  if {$B} {
    force -drive /adder_tb/iB.DATA1 1 [expr round(rand()*5)]
	force -drive /adder_tb/iB.DATA0 0 [expr round(rand()*5)]
  } else {
    force -drive /adder_tb/iB.DATA1 0 [expr round(rand()*5)]
	force -drive /adder_tb/iB.DATA0 1 [expr round(rand()*5)]
  }
  
  if {$C} {
    force -drive /adder_tb/iC.DATA1 1 [expr round(rand()*5)]
	force -drive /adder_tb/iC.DATA0 0 [expr round(rand()*5)]
  } else {
    force -drive /adder_tb/iC.DATA1 0 [expr round(rand()*5)]
	force -drive /adder_tb/iC.DATA0 1 [expr round(rand()*5)]
  }
}

proc null_inputs {} {
  force -drive /adder_tb/iA.DATA1 0 [expr round(rand()*5)]
  force -drive /adder_tb/iA.DATA0 0 [expr round(rand()*5)]
	
  force -drive /adder_tb/iB.DATA1 0 [expr round(rand()*5)]
  force -drive /adder_tb/iB.DATA0 0 [expr round(rand()*5)]
	
  force -drive /adder_tb/iC.DATA1 0 [expr round(rand()*5)]
  force -drive /adder_tb/iC.DATA0 0 [expr round(rand()*5)]
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/FullAdder.vhd ncl/components/Register.vhd ncl/tests/Adder_tb.vhd
view wave
delete wave *
vsim -quiet work.adder_tb

quietly virtual signal -install /adder_tb { (context /adder_tb )(iA.data0 & iA.data1 )} {iA_virt}
quietly virtual signal -install /adder_tb { (context /adder_tb )(iB.data0 & iB.data1 )} {iB_virt}
quietly virtual signal -install /adder_tb { (context /adder_tb )(iC.data0 & iC.data1 )} {iC_virt}
quietly virtual signal -install /adder_tb { (context /adder_tb )(oS.data0 & oS.data1 )} {oS_virt}
quietly virtual signal -install /adder_tb { (context /adder_tb )(oC.data0 & oC.data1 )} {oC_virt}

quietly virtual signal -install /adder_tb/Adder { (context /adder_tb/Adder )(iA.data0 & iA.data1 )} {a_virt}
quietly virtual signal -install /adder_tb/Adder { (context /adder_tb/Adder )(iB.data0 & iB.data1 )} {b_virt}
quietly virtual signal -install /adder_tb/Adder { (context /adder_tb/Adder )(iC.data0 & iC.data1 )} {iC_virt}
quietly virtual signal -install /adder_tb/Adder { (context /adder_tb/Adder )(oS.data0 & oS.data1 )} {oS_virt}
quietly virtual signal -install /adder_tb/Adder { (context /adder_tb/Adder )(oC.data0 & oC.data1 )} {oC_virt}

#quietly virtual signal -install /adder_tb/RegBefore { (context /adder_tb/RegBefore )(inputs(0).data0 & inputs(0).data1 )} {i0_virt}
#quietly virtual signal -install /adder_tb/RegBefore { (context /adder_tb/RegBefore )(inputs(1).data0 & inputs(1).data1 )} {i1_virt}
#quietly virtual signal -install /adder_tb/RegBefore { (context /adder_tb/RegBefore )(inputs(2).data0 & inputs(2).data1 )} {i2_virt}
#quietly virtual signal -install /adder_tb/RegBefore { (context /adder_tb/RegBefore )(output(0).data0 & output(0).data1 )} {o0_virt}
#quietly virtual signal -install /adder_tb/RegBefore { (context /adder_tb/RegBefore )(output(1).data0 & output(1).data1 )} {o1_virt}
#quietly virtual signal -install /adder_tb/RegBefore { (context /adder_tb/RegBefore )(output(2).data0 & output(2).data1 )} {o2_virt}

add wave -divider "Inputs"
add wave -radix ncl_pair_in -label "Input A" -color $input_color sim:/adder_tb/iA_virt
add wave -radix ncl_pair_in -label "Input B" -color $input_color sim:/adder_tb/iB_virt
add wave -radix ncl_pair_in -label "Input C" -color $input_color sim:/adder_tb/iC_virt

add wave -divider "Outputs"
add wave -radix ncl_pair_out -label "Output S" -color $input_color sim:/adder_tb/oS_virt
add wave -radix ncl_pair_out -label "Output C" -color $input_color sim:/adder_tb/oC_virt

#add wave -height 50 -divider "Internals"
#
#add wave -divider "RegBefore"
#add wave -label "in(0)" -radix ncl_pair_in -color $input_color /adder_tb/RegBefore/i0_virt
#add wave -label "in(1)" -radix ncl_pair_in -color $input_color /adder_tb/RegBefore/i1_virt
#add wave -label "in(2)" -radix ncl_pair_in -color $input_color /adder_tb/RegBefore/i2_virt
#add wave -label "out(0)" -radix ncl_pair_out -color $input_color /adder_tb/RegBefore/o0_virt
#add wave -label "out(1)" -radix ncl_pair_out -color $input_color /adder_tb/RegBefore/o1_virt
#add wave -label "out(2)" -radix ncl_pair_out -color $input_color /adder_tb/RegBefore/o2_virt
#
#add wave -divider "Adder"
#add wave -label "iC" -radix ncl_pair_in -color $input_color /adder_tb/Adder/iC_virt
#add wave -label "A" -radix ncl_pair_in -color $input_color /adder_tb/Adder/a_virt
#add wave -label "B" -radix ncl_pair_in -color $input_color /adder_tb/Adder/b_virt
#add wave -label "oS" -radix ncl_pair_out -color $output_color /adder_tb/Adder/oS_virt
#add wave -label "oC" -radix ncl_pair_out -color $output_color /adder_tb/Adder/oC_virt
null_inputs_now
set expectedS 0
set expectedC 0
run 50
for {set A 0} {$A <= 1} {incr A} {
  for {set B 0} {$B <= 1} {incr B} {
    for {set C 0} {$C <= 1} {incr C} {
      null_inputs
	  while {[examine /adder_tb/to_prev] != 1} { run 1 }
	  run 10
	  #check
	  puts "Time: $now. S: $expectedS C: $expectedC"
	  set expectedS [expr (($A + $B + $C) >> 0) & 1]
	  set expectedC [expr (($A + $B + $C) >> 1) & 1]
	  set_inputs $A $B $C
	  while {[examine /adder_tb/to_prev] != 0} { run 1 }
	  run 10
    }
  }
}
puts "Time: $now. S: $expectedS C: $expectedC"

run 100