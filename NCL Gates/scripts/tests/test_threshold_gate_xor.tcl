set input_color #007fff
set output_color #00Cf00

proc check_result {prevState runtime} {
  set A [examine -time $runtime sim:/THxor0/A]
  set B [examine -time $runtime sim:/THxor0/B]
  set C [examine -time $runtime sim:/THxor0/C]
  set D [examine -time $runtime sim:/THxor0/D]
  set outstate [examine -time $runtime sim:/THxor0/output]
  
  set num_ins_set 0
  if {$A} {incr num_ins_set;}
  if {$B} {incr num_ins_set;}
  if {$C} {incr num_ins_set;}
  if {$D} {incr num_ins_set;}
  
  set adj_runtime [expr ($runtime - 0)]
  if {$num_ins_set == 0} {
    if {$outstate != 0} {
      puts "Time: $adj_runtime, expected 0, got $outstate (gate reset)"
	  return 1
    }
  } elseif {[expr ($A & $B) + ($C & $D)]} {
    if {$outstate != 1} {
      puts "Time: $adj_runtime, expected 1, got $outstate (gate set)"
	  return 1
    }
  } else {
    if {$outstate != $prevState} {
      puts "Time: $adj_runtime, expected $prevState, got $outstate (gate unchanged)"
	  return 1
    }
  }
  return 0;
}

proc null_inputs { runtime } {
  force -freeze sim:/THxor0/A 0 $runtime
  force -freeze sim:/THxor0/B 0 $runtime
  force -freeze sim:/THxor0/C 0 $runtime
  force -freeze sim:/THxor0/D 0 $runtime
}

proc set_inputs { val runtime } {
  force -freeze sim:/THxor0/A [expr ($val >> 0) & 1] $runtime
  force -freeze sim:/THxor0/B [expr ($val >> 1) & 1] $runtime
  force -freeze sim:/THxor0/C [expr ($val >> 2) & 1] $runtime
  force -freeze sim:/THxor0/D [expr ($val >> 3) & 1] $runtime
}

proc test_threshold_gate_xor {} {
  global input_color input_color
  global output_color output_color
  
  vsim -quiet -gui work.THxor0
  
  add wave -radix hexadecimal -label "A" -color $input_color sim:/THxor0/A
  add wave -radix hexadecimal -label "B" -color $input_color sim:/THxor0/B
  add wave -radix hexadecimal -label "C" -color $input_color sim:/THxor0/C
  add wave -radix hexadecimal -label "D" -color $input_color sim:/THxor0/D
  quietly virtual signal -install sim:/THxor0 { (context sim:/THxor0 )(A & B & C & D )} {in_virt}
  add wave -radix hexadecimal -label "In" -color $input_color sim:/THxor0/in_virt
  add wave -radix hexadecimal -label "out" -color $output_color sim:/THxor0/output
  
  set runtime 0
  for {set start 0} {$start < [expr { pow(2,4) }]} {incr start} {
    for {set end 0} {$end < [expr { pow(2,4) }]} {incr end} {
      # InitialState = 0
	  set_inputs 0 $runtime
	  incr runtime 50
	  set_inputs $start $runtime
	  incr runtime 50
	  set_inputs $end $runtime
	  incr runtime 50
	  
	  # InitialState = 1
	  set_inputs [expr {int(pow(2,4)-1)}] $runtime
	  incr runtime 50
	  set_inputs $start $runtime
	  incr runtime 50
	  set_inputs $end $runtime
	  incr runtime 50
	}
  }
  run $runtime
  
  set error 0
  set prevState 0
  for {set time 25} {$time < $runtime} {incr time 50} {
    set localerror [check_result $prevState $time]
    set prevState [examine -time $time sim:/THxor0/output]
	if {$localerror} {set error 1}
  }
  return $error
}
  