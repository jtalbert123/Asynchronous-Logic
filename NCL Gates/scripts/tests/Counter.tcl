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
    force -drive /counter_tb/iA.DATA1 1 0
	force -drive /counter_tb/iA.DATA0 0 0
  } else {
    force -drive /counter_tb/iA.DATA1 0 0
	force -drive /counter_tb/iA.DATA0 1 0
  }
  
  if {$B} {
    force -drive /counter_tb/iB.DATA1 1 0
	force -drive /counter_tb/iB.DATA0 0 0
  } else {
    force -drive /counter_tb/iB.DATA1 0 0
	force -drive /counter_tb/iB.DATA0 1 0
  }
  
  if {$C} {
    force -drive /counter_tb/iC.DATA1 1 0
	force -drive /counter_tb/iC.DATA0 0 0
  } else {
    force -drive /counter_tb/iC.DATA1 0 0
	force -drive /counter_tb/iC.DATA0 1 0
  }
}

proc null_inputs_now {} {
    force -drive /counter_tb/iA.DATA1 0 0
	force -drive /counter_tb/iA.DATA0 0 0
	
    force -drive /counter_tb/iB.DATA1 0 0
	force -drive /counter_tb/iB.DATA0 0 0
	
    force -drive /counter_tb/iC.DATA1 0 0
	force -drive /counter_tb/iC.DATA0 0 0
}

proc set_inputs {A B C} {
  if {$A} {
    force -drive /counter_tb/iA.DATA1 1 [expr round(rand()*5)]
	force -drive /counter_tb/iA.DATA0 0 [expr round(rand()*5)]
  } else {
    force -drive /counter_tb/iA.DATA1 0 [expr round(rand()*5)]
	force -drive /counter_tb/iA.DATA0 1 [expr round(rand()*5)]
  }
  
  if {$B} {
    force -drive /counter_tb/iB.DATA1 1 [expr round(rand()*5)]
	force -drive /counter_tb/iB.DATA0 0 [expr round(rand()*5)]
  } else {
    force -drive /counter_tb/iB.DATA1 0 [expr round(rand()*5)]
	force -drive /counter_tb/iB.DATA0 1 [expr round(rand()*5)]
  }
  
  if {$C} {
    force -drive /counter_tb/iC.DATA1 1 [expr round(rand()*5)]
	force -drive /counter_tb/iC.DATA0 0 [expr round(rand()*5)]
  } else {
    force -drive /counter_tb/iC.DATA1 0 [expr round(rand()*5)]
	force -drive /counter_tb/iC.DATA0 1 [expr round(rand()*5)]
  }
}

proc null_inputs {} {
    force -drive /counter_tb/iA.DATA1 0 [expr round(rand()*5)]
	force -drive /counter_tb/iA.DATA0 0 [expr round(rand()*5)]
	
    force -drive /counter_tb/iB.DATA1 0 [expr round(rand()*5)]
	force -drive /counter_tb/iB.DATA0 0 [expr round(rand()*5)]
	
    force -drive /counter_tb/iC.DATA1 0 [expr round(rand()*5)]
	force -drive /counter_tb/iC.DATA0 0 [expr round(rand()*5)]
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/FullAdder.vhd ncl/components/Register.vhd ncl/tests/CounterTest.vhd
view wave
delete wave *
vsim -quiet work.counter_tb

quietly virtual signal -install /counter_tb { (context /counter_tb )(iA.data0 & iA.data1 )} {iA_virt}
quietly virtual signal -install /counter_tb { (context /counter_tb )(iB.data0 & iB.data1 )} {iB_virt}
quietly virtual signal -install /counter_tb { (context /counter_tb )(iC.data0 & iC.data1 )} {iC_virt}
quietly virtual signal -install /counter_tb { (context /counter_tb )(oS.data0 & oS.data1 )} {oS_virt}
quietly virtual signal -install /counter_tb { (context /counter_tb )(oC.data0 & oC.data1 )} {oC_virt}

quietly virtual signal -install /counter_tb/Adder { (context /counter_tb/Adder )(a.data0 & a.data1 )} {a_virt}
quietly virtual signal -install /counter_tb/Adder { (context /counter_tb/Adder )(b.data0 & b.data1 )} {b_virt}
quietly virtual signal -install /counter_tb/Adder { (context /counter_tb/Adder )(cin.data0 & cin.data1 )} {cin_virt}
quietly virtual signal -install /counter_tb/Adder { (context /counter_tb/Adder )(sum.data0 & sum.data1 )} {sum_virt}
quietly virtual signal -install /counter_tb/Adder { (context /counter_tb/Adder )(cout.data0 & cout.data1 )} {cout_virt}

#quietly virtual signal -install /counter_tb/RegBefore { (context /counter_tb/RegBefore )(inputs(0).data0 & inputs(0).data1 )} {i0_virt}
#quietly virtual signal -install /counter_tb/RegBefore { (context /counter_tb/RegBefore )(inputs(1).data0 & inputs(1).data1 )} {i1_virt}
#quietly virtual signal -install /counter_tb/RegBefore { (context /counter_tb/RegBefore )(inputs(2).data0 & inputs(2).data1 )} {i2_virt}
#quietly virtual signal -install /counter_tb/RegBefore { (context /counter_tb/RegBefore )(output(0).data0 & output(0).data1 )} {o0_virt}
#quietly virtual signal -install /counter_tb/RegBefore { (context /counter_tb/RegBefore )(output(1).data0 & output(1).data1 )} {o1_virt}
#quietly virtual signal -install /counter_tb/RegBefore { (context /counter_tb/RegBefore )(output(2).data0 & output(2).data1 )} {o2_virt}

add wave -divider "Inputs"
add wave -radix ncl_pair_in -label "Input A" -color $input_color sim:/counter_tb/iA_virt
add wave -radix ncl_pair_in -label "Input B" -color $input_color sim:/counter_tb/iB_virt
add wave -radix ncl_pair_in -label "Input C" -color $input_color sim:/counter_tb/iC_virt

add wave -divider "Outputs"
add wave -radix ncl_pair_out -label "Output S" -color $input_color sim:/counter_tb/oS_virt
add wave -radix ncl_pair_out -label "Output C" -color $input_color sim:/counter_tb/oC_virt

#add wave -height 50 -divider "Internals"
#
#add wave -divider "RegBefore"
#add wave -label "in(0)" -radix ncl_pair_in -color $input_color /counter_tb/RegBefore/i0_virt
#add wave -label "in(1)" -radix ncl_pair_in -color $input_color /counter_tb/RegBefore/i1_virt
#add wave -label "in(2)" -radix ncl_pair_in -color $input_color /counter_tb/RegBefore/i2_virt
#add wave -label "out(0)" -radix ncl_pair_out -color $input_color /counter_tb/RegBefore/o0_virt
#add wave -label "out(1)" -radix ncl_pair_out -color $input_color /counter_tb/RegBefore/o1_virt
#add wave -label "out(2)" -radix ncl_pair_out -color $input_color /counter_tb/RegBefore/o2_virt
#
#add wave -divider "Adder"
#add wave -label "Cin" -radix ncl_pair_in -color $input_color /counter_tb/Adder/cin_virt
#add wave -label "A" -radix ncl_pair_in -color $input_color /counter_tb/Adder/a_virt
#add wave -label "B" -radix ncl_pair_in -color $input_color /counter_tb/Adder/b_virt
#add wave -label "Sum" -radix ncl_pair_out -color $output_color /counter_tb/Adder/sum_virt
#add wave -label "Cout" -radix ncl_pair_out -color $output_color /counter_tb/Adder/cout_virt
null_inputs_now
run 50
for {set A 0} {$A <= 1} {incr A} {
  for {set B 0} {$B <= 1} {incr B} {
    for {set C 0} {$C <= 1} {incr C} {
      null_inputs
	  while {[examine /counter_tb/to_prev] != 1} { run 1 }
	  run 10
	  set_inputs $A $B $C
	  while {[examine /counter_tb/to_prev] != 0} { run 1 }
	  run 10
    }
  }
}

run 100