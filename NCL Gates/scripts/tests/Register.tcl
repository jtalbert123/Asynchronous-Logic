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

# 3 inputs + control

proc setup_input_signals { } {
  global input_color input_color
  global output_color output_color
  add wave -divider "Inputs"
  for {set i 0} {$i < 3} {incr i} {
    quietly virtual signal -install sim:/RegisterN " (context sim:/RegisterN )(inputs($i).data0 & inputs($i).data1 )" "i${i}_virt"
	add wave -radix ncl_pair_in -label "i${i}" sim:/RegisterN/i${i}_virt
  }
  add wave -color $input_color -label "from_next" sim:/RegisterN/from_next
  
  add wave -divider "Outputs"
  for {set i 0} {$i < 3} {incr i} {
	quietly virtual signal -install sim:/RegisterN " (context sim:/RegisterN )(output($i).data0 & output($i).data1 )" "o${i}_virt"
	add wave -radix ncl_pair_out -label "o${i}" sim:/RegisterN/o${i}_virt
  }
  add wave -color $output_color -label "to_prev" sim:/RegisterN/to_prev
}

proc set_inputs { A B C from_next } {
  force -freeze sim:/RegisterN/inputs(0).DATA1 $A
  force -freeze sim:/RegisterN/inputs(0).DATA0 [expr 1-$A]
  force -freeze sim:/RegisterN/inputs(1).DATA1 $B
  force -freeze sim:/RegisterN/inputs(1).DATA0 [expr 1-$B]
  force -freeze sim:/RegisterN/inputs(2).DATA1 $C
  force -freeze sim:/RegisterN/inputs(2).DATA0 [expr 1-$C]
  force -freeze sim:/RegisterN/from_next $from_next
  run 0;
}

proc null_inputs { from_next } {
  for {set i 0} {$i < 3} {incr i} {
    force -freeze sim:/RegisterN/inputs($i).DATA1 0
	force -freeze sim:/RegisterN/inputs($i).DATA0 0
  }
  force -freeze sim:/RegisterN/from_next $from_next
  run 0;
}

proc expect_null { } {
  global now now
  set is_null 1
  set has_null 0
  for {set i 0} {$i < 3} {incr i} {
    if {[expr ([examine sim:/output($i).DATA0] != 0) + ([examine sim:/output($i).DATA1] != 0)]} {
	  set is_null 0
    }
  }
  if {$is_null == 0} {
    puts "Time: $now Expected the output to be NULL. Was not NULL"
  }
}

proc expect_data { A B C } {
  global now now
  set is_data 1
  for {set i 0} {$i < 3} {incr i} {
    if {[expr ([examine sim:/output($i).DATA0] == 0) * ([examine sim:/output($i).DATA1] == 0)]} {
	  set is_data 0
    }
  }
  set tabbed 0
  if {$is_data == 0} {
    puts "Time: $now. Expected the output to be DATA. Was not DATA"
	set tabbed 1
  }
  if {[examine sim:/RegisterN/o0_virt] != $A} {
    if {$tabbed == 0} { puts "Time: $now."}
    puts "    A: Expected $A, got [examine sim:/RegisterN/i0_virt]"
	set tabbed 1
  }
  if {[examine sim:/RegisterN/o1_virt] != $B} {
    if {$tabbed == 0} { puts "Time: $now."}
    puts "    A: Expected $B, got [examine sim:/RegisterN/i1_virt]"
	set tabbed 1
  }
  if {[examine sim:/RegisterN/o2_virt] != $C} {
    if {$tabbed == 0} { puts "Time: $now."}
    puts "    C: Expected $C, got [examine sim:/RegisterN/i2_virt]"
	set tabbed 1
  }
}

vsim work.RegisterN -g N=3
setup_input_signals
set prevA 0
set prevB 0
set prevC 0
set_inputs 0 0 0 1
run 25
for {set A 0} {$A <= 1} {incr A} {
  for {set B 0} {$B <= 1} {incr B} {
    for {set C 0} {$C <= 1} {incr C} {
      null_inputs 1
	  run 25
	  expect_data $prevA $prevB $prevC
	  null_inputs 0
	  run 25
	  expect_null
	  set_inputs $A $B $C 0
	  run 25
	  expect_null
	  set_inputs $A $B $C 1
	  run 25
	  expect_data $A $B $C
	  set prevA $A
	  set prevB $B
	  set prevC $C
    }
  }
}