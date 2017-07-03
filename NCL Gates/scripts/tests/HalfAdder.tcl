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

proc null_out {runtime} {
  force -freeze sim:/halfadder/a.data0 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/halfadder/a.data1 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/halfadder/b.data0 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/halfadder/b.data1 0 [expr $runtime+round(rand()*5)]
}

proc set_inputs {runtime a b} {
  if {$a} {
    force -freeze sim:/halfadder/a.data0 0 [expr $runtime+round(rand()*5)]
	force -freeze sim:/halfadder/a.data1 1 [expr $runtime+round(rand()*5)]
  } else {
    force -freeze sim:/halfadder/a.data0 1 [expr $runtime+round(rand()*5)]
	force -freeze sim:/halfadder/a.data1 0 [expr $runtime+round(rand()*5)]
  }
  if {$b} {
    force -freeze sim:/halfadder/b.data0 0 [expr $runtime+round(rand()*5)]
	force -freeze sim:/halfadder/b.data1 1 [expr $runtime+round(rand()*5)]
  } else {
    force -freeze sim:/halfadder/b.data0 1 [expr $runtime+round(rand()*5)]
	force -freeze sim:/halfadder/b.data1 0 [expr $runtime+round(rand()*5)]
  }
}

proc check {runtime} {
  set num 0
  set isnull 1
  if {[examine /halfadder/a.data1 -time $runtime]} {
    incr num
	set isnull 0
  } elseif {[examine /halfadder/a.data0 -time $runtime]} {
    set isnull 0
  }
  if {[examine /halfadder/b.data1 -time $runtime]} {
    incr num
	set isnull 0
  } elseif {[examine /halfadder/b.data0 -time $runtime]} {
    set isnull 0
  }
  set cout [examine /halfadder/Flat_C -time $runtime]
  set sout [examine /halfadder/Flat_S -time $runtime]
  set error 0
  if {isnull} {
    if {$cout} {
	  puts "Time: $runtime. Expected Null on Carry out signal"
	  set error 1
	}
	if {$sout} {
	  puts "Time: $runtime. Expected Null on Sum out signal"
	  set error 1
	}
  } else {
    if {$num==0} {
	  if {$cout != 2} {
	    puts "Time: $runtime. Expected 0 on Carry out signal"
	    set error 1
	  }
	  if {$sout != 2} {
	    puts "Time: $runtime. Expected 0 on Sum out signal"
	    set error 1
	  }
	} elseif {$num==1} {
	  if {$cout != 2} {
	    puts "Time: $runtime. Expected 0 on Carry out signal"
	    set error 1
	  }
	  if {$sout != 1} {
	    puts "Time: $runtime. Expected 1 on Sum out signal"
	    set error 1
	  }
	} elseif {$num==2} {
	  if {$cout != 1} {
	    puts "Time: $runtime. Expected 1 on Carry out signal"
	    set error 1
	  }
	  if {$sout != 2} {
	    puts "Time: $runtime. Expected 0 on Sum out signal"
	    set error 1
	  }
	}
  }
  return error;
}

proc test_HA {} {
  global input_color input_color
  global output_color output_color
  
  view wave
  delete wave *
  vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/HalfAdder.vhd
  vsim -quiet -gui work.HalfAdder
  
  quietly virtual signal -install /halfadder { (context /halfadder )(a.data0 & a.data1 )} {Flat_A}
  quietly virtual signal -install /halfadder { (context /halfadder )(b.data0 & b.data1 )} {Flat_B}
  quietly virtual signal -install /halfadder { (context /halfadder )(c.data0 & c.data1 )} {Flat_C}
  quietly virtual signal -install /halfadder { (context /halfadder )(s.data0 & s.data1 )} {Flat_S}
  add wave -radix ncl_pair_in -label "Input A" -color $input_color sim:/halfadder/flat_a
  add wave -radix ncl_pair_in -label "Input B" -color $input_color sim:/halfadder/flat_b
  
  add wave -radix ncl_pair_out -label "Output S" -color $output_color sim:/halfadder/flat_s
  add wave -radix ncl_pair_out -label "Output C" -color $output_color sim:/halfadder/flat_c
  
  force -freeze sim:/halfadder/a.data0 0 0
  force -freeze sim:/halfadder/a.data1 0 0
  force -freeze sim:/halfadder/b.data0 0 0
  force -freeze sim:/halfadder/b.data1 0 0
  
  set runtime 0
  null_out $runtime
  incr runtime 50
  set_inputs $runtime 0 0
  incr runtime 50
  null_out $runtime
  incr runtime 50
  set_inputs $runtime 0 1
  incr runtime 50
  null_out $runtime
  incr runtime 50
  set_inputs $runtime 1 0
  incr runtime 50
  null_out $runtime
  incr runtime 50
  set_inputs $runtime 1 1
  incr runtime 50

  run $runtime
  return;
  set error 0
  set prevState 0
  for {set time 25} {$time < $runtime} {incr time 50} {
    set localerror [check_result $N $M $prevState $time]
	check $runtime
	if {$localerror} {set error 1}
  }
  return $error 
}