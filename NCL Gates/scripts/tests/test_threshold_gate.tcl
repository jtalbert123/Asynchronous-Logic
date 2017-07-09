set input_color #007fff
set output_color #00Cf00

proc check_result {N M prevState runtime} {
  set instate_hex [examine -time $runtime sim:/THmn/inputs]
  set outstate [examine -time $runtime sim:/THmn/output]
  scan $instate_hex %x instate
  
  set num_ins_set 0
  for {set i 0} {$i < $N} {incr i} {
    if {[expr ((1 << $i) & $instate) > 0]} {
	  incr num_ins_set 1
	}
  }
  set adj_runtime [expr ($runtime - 0)]
  if {$num_ins_set == 0} {
    if {$outstate != 0} {
      puts "Time: $adj_runtime, expected 0, got $outstate (gate reset)"
	  return 1
    }
  } elseif {$num_ins_set >= $M} {
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

proc test_threshold_gate {N M} {
  global input_color input_color
  global output_color output_color
  
  vsim -quiet -gui work.THmn -g N=$N -g M=$M
  
  add wave -radix hexadecimal -label "in" -color $input_color sim:/THmn/inputs
  add wave -radix hexadecimal -label "out" -color $output_color sim:/THmn/output
  
  set runtime 0
  for {set start 0} {$start < [expr { pow(2,$N) }]} {incr start} {
    for {set end 0} {$end < [expr { pow(2,$N) }]} {incr end} {
      # InitialState = 0
	  force -freeze sim:/THmn/inputs 0 $runtime
	  incr runtime 50
	  force -freeze sim:/THmn/inputs [format %X $start] $runtime
	  incr runtime 50
	  force -freeze sim:/THmn/inputs [format %X $end] $runtime
	  incr runtime 50
	  
	  # InitialState = 1
	  force -freeze sim:/THmn/inputs [format %X [expr {int(pow(2,$N)-1)}]] $runtime
	  incr runtime 50
	  force -freeze sim:/THmn/inputs [format %X $start] $runtime
	  incr runtime 50
	  force -freeze sim:/THmn/inputs [format %X $end] $runtime
	  incr runtime 50
	}
  }
  run $runtime
  
  set error 0
  set prevState 0
  for {set time 25} {$time < $runtime} {incr time 50} {
    set localerror [check_result $N $M $prevState $time]
    set prevState [examine -time $time sim:/THmn/output]
	if {$localerror} {set error 1}
  }
  return $error
}

proc run_gate_tests { N } {
  
  view wave
  delete wave *
  vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd
  #vopt -quiet -check_synthesis -work work work.THmn
  
  set result "No Errors"
  for {set inputs 1} {$inputs <= $N} {incr inputs} {
    for {set threshold 1} {$threshold <= $inputs} {incr threshold} {
	  puts "Testing T${inputs}${threshold}"
      set localerror [test_threshold_gate $inputs $threshold]
	  if {[expr $localerror & [string equal $result "No Errors"]]} {set result "First error(s) in T${inputs}${threshold}"}
	  if {$localerror} {puts "Error"} else {puts "Clear"}
	  puts ""
    }
  }
  puts $result
}
  