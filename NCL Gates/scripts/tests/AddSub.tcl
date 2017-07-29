set NumBits 2

# Unfortunately, for unknown reasons, I have to do the force commands
#   during a live session, with run commands every so often. I suspect
#   this is due to limitations of ModelSim PE Student Edition

set input_color #007fff
set output_color #00Cf00

radix define ncl_pair_in {
  "0" _ -color #606060
  "1" 1 -color #007fff
  "2" 0 -color #007fff
  "3" Invalid -color #007fff
}

radix define operation_in {
  "0" _ -color #606060
  "1" - -color #00c0ff
  "2" + -color #C080ff
  "3" Invalid -color #007fff
}

radix define ncl_pair_out {
  "0" _ -color #606060
  "1" 1 -color #00Cf00
  "2" 0 -color #00Cf00
  "3" Invalid -color #00Cf00
}

proc null_out_now {runtime} {
  global NumBits NumBits
  for {set i 0} {$i < $NumBits} {incr i} {
    force -freeze sim:/AddSub/iA($i).data0 0 $runtime
    force -freeze sim:/AddSub/iA($i).data1 0 $runtime
    force -freeze sim:/AddSub/iB($i).data0 0 $runtime
    force -freeze sim:/AddSub/iB($i).data1 0 $runtime
    run 0
  }
  force -freeze sim:/AddSub/Operation.data0 0 $runtime
  force -freeze sim:/AddSub/Operation.data1 0 $runtime
  run 0
}

proc null_out {runtime} {
  global NumBits NumBits
  for {set i 0} {$i < $NumBits} {incr i} {
    force -freeze sim:/AddSub/iA($i).data0 0 [expr $runtime+round(rand()*5)]
    force -freeze sim:/AddSub/iA($i).data1 0 [expr $runtime+round(rand()*5)]
    force -freeze sim:/AddSub/iB($i).data0 0 [expr $runtime+round(rand()*5)]
    force -freeze sim:/AddSub/iB($i).data1 0 [expr $runtime+round(rand()*5)]
    run 0
  }
  force -freeze sim:/AddSub/Operation.data0 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/AddSub/Operation.data1 0 [expr $runtime+round(rand()*5)]
  run 0
}

proc set_inputs {runtime A B Op} {
  global NumBits NumBits
  for {set i 0} {$i < $NumBits} {incr i} {
    force -freeze sim:/AddSub/iA($i).data0 [expr (($A >> $i) & 1) == 0] [expr $runtime+round(rand()*5)]
    force -freeze sim:/AddSub/iA($i).data1 [expr (($A >> $i) & 1) == 1] [expr $runtime+round(rand()*5)]
    force -freeze sim:/AddSub/iB($i).data0 [expr (($B >> $i) & 1) == 0] [expr $runtime+round(rand()*5)]
    force -freeze sim:/AddSub/iB($i).data1 [expr (($B >> $i) & 1) == 1] [expr $runtime+round(rand()*5)]
    run 0
  }
  force -freeze sim:/AddSub/Operation.data0 [expr $Op == 0] [expr $runtime+round(rand()*5)]
  force -freeze sim:/AddSub/Operation.data1 [expr $Op == 1] [expr $runtime+round(rand()*5)]
  run 0
}

proc check {} {
  global now
  global NumBits NumBits
  set isnull 1
  set isdata 1
  set error 0
  
  for {set i 0} {$i < $NumBits} {incr i} {
    set a_n_0 [examine sim:/AddSub/iA($i).data0]
    set a_n_1 [examine sim:/AddSub/iA($i).data1]
    
    set b_n_0 [examine sim:/AddSub/iB($i).Data0]
    set b_n_1 [examine sim:/AddSub/iB($i).data1]
    
    if {[expr ($a_n_0 + $a_n_1) + ($b_n_0 + $b_n_1)]} {set isnull 0}
    if {[expr (($a_n_0 + $a_n_1) == 0) + (($b_n_0 + $b_n_1) == 0)]} {set isdata 0}
  }
  set o_0 [examine sim:/AddSub/Operation.dAta0]
  set o_1 [examine sim:/AddSub/Operation.data1]
   
  if {[expr ($o_0 + $o_1)]} {set isnull 0} else {set isdata 0}
  
  if {$isnull} {
    for {set i 0} {$i < $NumBits} {incr i} {
      set s_n_0 [examine sim:/AddSub/iA($i).daTa0]
      set s_n_1 [examine sim:/AddSub/iA($i).data1]
    
      if {[expr ($s_n_0 + $s_n_1)]} {puts "Time: $now. Got Some DATA with NULL input"; set error 1}
    }
	set c_0 [examine sim:/AddSub/oC.datA0]
    set c_1 [examine sim:/AddSub/oC.data1]
    
    if {[expr ($c_0 + $c_1)]} {puts "Time: $now. Got Some DATA with NULL input"; set error 1}
  } elseif {$isdata} {
    set a 0
    set b 0
	set s 0
    set sum 0
	
    for {set i 0} {$i < $NumBits} {incr i} {
      set a_n [examine sim:/AddSub/iA($i).data1]
      set b_n [examine sim:/AddSub/iB($i).data1]
	  set s_n [examine sim:/AddSub/oS($i).data1]
      
	  set a [expr $a + ($a_n << $i)]
	  set b [expr $b + ($b_n << $i)]
	  set s [expr $s + ($s_n << $i)]
    }
	if {$o_0} {set sum [expr ($a+$b)]} else {set sum [expr ($a-$b)]}
    set sum [expr $sum & ((2**$NumBits)-1)]
	if {$s != $sum} { puts "Time: $now. Incorrect Sum: $s != $sum"; set error 1}
  }
  
  return error;
}

proc test_AddSub {} {
  global input_color input_color
  global output_color output_color
  global NumBits NumBits
  global now
  
  view wave
  delete wave *
  vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/Adder.vhd ncl/components/FullAdder.vhd ncl/components/AddSub.vhd
  vsim -quiet -gui work.AddSub -gNumBits=$NumBits
  
  for {set i 0} {$i < $NumBits} {incr i} {
    quietly virtual signal -install /AddSub " (context /AddSub )(iA($i).data0 & iA($i).data1 )" "Flat_iA${i}"
    quietly virtual signal -install /AddSub " (context /AddSub )(iB($i).data0 & iB($i).data1 )" "Flat_iB${i}"
    quietly virtual signal -install /AddSub " (context /AddSub )(oS($i).data0 & oS($i).data1 )" "Flat_oS${i}"
  }
  quietly virtual signal -install /AddSub "(context /AddSub )(oC.data0 & oC.data1 )" Flat_oC
  quietly virtual signal -install /AddSub "(context /AddSub )(Operation.data0 & Operation.data1 )" Flat_Operation
  add wave -divider {Input A}
  for {set i 0} {$i < $NumBits} {incr i} {
    add wave -radix ncl_pair_in -label "Input A $i" -color $input_color sim:/AddSub/flat_ia${i}
  }
  add wave -divider {Input B}
  for {set i 0} {$i < $NumBits} {incr i} {
    add wave -radix ncl_pair_in -label "Input B $i" -color $input_color sim:/AddSub/flat_ib${i}
  }
  
  add wave -divider {Control}
  add wave -radix operation_in -label "Operation" -color $output_color sim:/AddSub/flat_Operation
  
  add wave -divider {Output}
  for {set i 0} {$i < $NumBits} {incr i} {
    add wave -radix ncl_pair_out -label "Output Sum $i" -color $output_color sim:/AddSub/flat_oS${i}
  }
  add wave -height 5 -divider {Carry}
  add wave -radix ncl_pair_out -label "Output Carry" -color $output_color sim:/AddSub/flat_oC

  set runtime 0
  null_out_now $runtime
  for {set a 0} {$a < [expr 2**$NumBits]} {incr a} {
    for {set b 0} {$b < [expr 2**$NumBits]} {incr b} {
      null_out 0
      incr runtime 50
      run 50
	  check
      set_inputs 0 $a $b 0
      incr runtime 50
      run 50
	  check
	  
      null_out 0
      incr runtime 50
      run 50
	  check
      set_inputs 0 $a $b 1
      incr runtime 50
      run 50
	  check
    }
  }
}
