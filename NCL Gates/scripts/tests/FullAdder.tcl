
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

proc null_out_now {runtime} {
  force -freeze sim:/fulladder/iA.data0 0 $runtime
  force -freeze sim:/fulladder/iA.data1 0 $runtime
  force -freeze sim:/fulladder/iB.data0 0 $runtime
  force -freeze sim:/fulladder/iB.data1 0 $runtime
  force -freeze sim:/fulladder/iC.data0 0 $runtime
  force -freeze sim:/fulladder/iC.data1 0 $runtime
}

proc null_out {runtime} {
  force -freeze sim:/fulladder/iA.data0 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/fulladder/iA.data1 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/fulladder/iB.data0 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/fulladder/iB.data1 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/fulladder/iC.data0 0 [expr $runtime+round(rand()*5)]
  force -freeze sim:/fulladder/iC.data1 0 [expr $runtime+round(rand()*5)]
}

proc set_inputs {runtime a b c} {
  if {$a} {
    force -freeze sim:/fulladder/iA.data0 0 [expr $runtime+round(rand()*5)]
    force -freeze sim:/fulladder/iA.data1 1 [expr $runtime+round(rand()*5)]
  } else {
    force -freeze sim:/fulladder/iA.data0 1 [expr $runtime+round(rand()*5)]
    force -freeze sim:/fulladder/iA.data1 0 [expr $runtime+round(rand()*5)]
  }
  if {$b} {
    force -freeze sim:/fulladder/iB.data0 0 [expr $runtime+round(rand()*5)]
    force -freeze sim:/fulladder/iB.data1 1 [expr $runtime+round(rand()*5)]
  } else {
    force -freeze sim:/fulladder/iB.data0 1 [expr $runtime+round(rand()*5)]
    force -freeze sim:/fulladder/iB.data1 0 [expr $runtime+round(rand()*5)]
  }
  if {$c} {
    force -freeze sim:/fulladder/iC.data0 0 [expr $runtime+round(rand()*5)]
    force -freeze sim:/fulladder/iC.data1 1 [expr $runtime+round(rand()*5)]
  } else {
    force -freeze sim:/fulladder/iC.data0 1 [expr $runtime+round(rand()*5)]
    force -freeze sim:/fulladder/iC.data1 0 [expr $runtime+round(rand()*5)]
  }
}

proc check {runtime} {
  set num 0
  set isnull 1
  if {[examine /fulladder/iA.data1 -time $runtime]} {
    incr num
    set isnull 0
  } elseif {[examine /fulladder/iA.data0 -time $runtime]} {
    set isnull 0
  }
  if {[examine /fulladder/iB.data1 -time $runtime]} {
    incr num
    set isnull 0
  } elseif {[examine /fulladder/iB.data0 -time $runtime]} {
    set isnull 0
  }
  if {[examine /fulladder/iC.data1 -time $runtime]} {
    incr num
    set isnull 0
  } elseif {[examine /fulladder/iC.data0 -time $runtime]} {
    set isnull 0
  }
  set oC [examine /fulladder/Flat_oC -time $runtime]
  set sout [examine /fulladder/Flat_oS -time $runtime]
  set error 0
  if {isnull} {
    if {$oC} {
      puts "Time: $runtime. Expected Null on Carry out signal"
      set error 1
    }
    if {$sout} {
      puts "Time: $runtime. Expected Null on oS out signal"
      set error 1
    }
  } else {
    if {$num==0} {
      if {$oC != 2} {
        puts "Time: $runtime. Expected 0 on Carry out signal"
        set error 1
      }
      if {$sout != 2} {
        puts "Time: $runtime. Expected 0 on oS out signal"
        set error 1
      }
    } elseif {$num==1} {
      if {$oC != 2} {
        puts "Time: $runtime. Expected 0 on Carry out signal"
        set error 1
      }
      if {$sout != 1} {
        puts "Time: $runtime. Expected 1 on oS out signal"
        set error 1
      }
    } elseif {$num==2} {
      if {$oC != 1} {
        puts "Time: $runtime. Expected 1 on Carry out signal"
        set error 1
      }
      if {$sout != 2} {
        puts "Time: $runtime. Expected 0 on oS out signal"
        set error 1
      }
    } elseif {$num==3} {
      if {$oC != 1} {
        puts "Time: $runtime. Expected 1 on Carry out signal"
        set error 1
      }
      if {$sout != 1} {
        puts "Time: $runtime. Expected 1 on oS out signal"
        set error 1
      }
    }
  }
  return error;
}

proc test_FA {} {
  global input_color input_color
  global output_color output_color
  
  view wave
  delete wave *
  vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/FullAdder.vhd
  vsim -quiet -gui work.FullAdder
  
  quietly virtual signal -install /fulladder { (context /fulladder )(iA.data0 & iA.data1 )} {Flat_A}
  quietly virtual signal -install /fulladder { (context /fulladder )(iB.data0 & iB.data1 )} {Flat_B}
  quietly virtual signal -install /fulladder { (context /fulladder )(iC.data0 & iC.data1 )} {Flat_iC}
  quietly virtual signal -install /fulladder { (context /fulladder )(oC.data0 & oC.data1 )} {Flat_oC}
  quietly virtual signal -install /fulladder { (context /fulladder )(oS.data0 & oS.data1 )} {Flat_oS}
  add wave -radix ncl_pair_in -label "Input Carry" -color $input_color sim:/fulladder/flat_iC
  add wave -radix ncl_pair_in -label "Input A" -color $input_color sim:/fulladder/flat_a
  add wave -radix ncl_pair_in -label "Input B" -color $input_color sim:/fulladder/flat_b
  
  add wave -radix ncl_pair_out -label "Output Sum" -color $output_color sim:/fulladder/flat_oS
  add wave -radix ncl_pair_out -label "Output Carry" -color $output_color sim:/fulladder/flat_oC
  
  set runtime 0
  null_out_now $runtime
  for {set a 0} {$a <= 1} {incr a} {
    for {set b 0} {$b <= 1} {incr b} {
      for {set c 0} {$c <= 1} {incr c} {
        null_out $runtime
        incr runtime 50
        set_inputs $runtime $a $b $c
        incr runtime 50
      }
    }
  }
  
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