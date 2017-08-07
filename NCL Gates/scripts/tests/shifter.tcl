set NumBits 3
set NumControl 2
vsim -quiet -gui work.shifter -gNumInputs=$NumBits

radix define ncl_pair_in {
  "0" _ -color #606060
  "1" 1 -color #007fff
  "2" 0 -color #007fff
  "3" Invalid -color #007fff
}

radix define ncl_pair_out {
  "0" _ -color #606060
  "1" 1 -color #00Cf00
  "2" 0 -color #00Cf00
  "3" Invalid -color #00Cf00
}

radix define direction_pair_in {
  "0" _ -color #606060
  "1" Left -color #007fff
  "2" Right -color #007fff
  "3" Invalid -color #007fff
}

for {set i 0} {$i < $NumBits} {incr i} {
  quietly virtual signal -install sim:/shifter "(context sim:/shifter )(inputs($i).data0 & inputs($i).data1 )" "i${i}_virt"
  quietly virtual signal -install sim:/shifter "(context sim:/shifter )(output($i).data0 & output($i).data1 )" "o${i}_virt"
}

for {set i 0} {$i < $NumControl} {incr i} {
  quietly virtual signal -install sim:/shifter "(context sim:/shifter )(shift_amount($i).data0 & shift_amount($i).data1 )" "s${i}_virt"
}

quietly virtual signal -install sim:/shifter { (context sim:/shifter )(direction.data0 & direction.data1 )} {dir_virt}
quietly virtual signal -install sim:/shifter { (context sim:/shifter )(rotate.data0 & rotate.data1 )} {rot_virt}
quietly virtual signal -install sim:/shifter { (context sim:/shifter )(logical.data0 & logical.data1 )} {log_virt}
quietly virtual signal -install sim:/shifter { (context sim:/shifter )(non_rotate_in.data0 & non_rotate_in.data1 )} {nri_virt}

add wave -divider Input
for {set i 0} {$i < $NumBits} {incr i} {
  add wave -radix ncl_pair_in -label "Input($i)" sim:/shifter/i${i}_virt
}
add wave -divider Control
for {set i 0} {$i < $NumControl} {incr i} {
  add wave -radix ncl_pair_in -label "Shamt($i)" sim:/shifter/s${i}_virt
}
add wave -radix direction_pair_in -label "Direction" sim:/shifter/dir_virt
add wave -radix ncl_pair_in -label "Rotate?" sim:/shifter/rot_virt
add wave -radix ncl_pair_in -label "Logical?" sim:/shifter/log_virt

add wave -divider Output
for {set i 0} {$i < $NumBits} {incr i} {
  add wave -radix ncl_pair_out -label "Output($i)" sim:/shifter/o${i}_virt
}

add wave -radix ncl_pair_in -label "non_rotate_in" sim:/shifter/nri_virt

proc null_inputs {} {
  global NumBits
  global NumControl
  for {set i 0} {$i < $NumBits} {incr i} {
    force -deposit sim:/shifter/inputs($i).DATA0 0 0
	force -deposit sim:/shifter/inputs($i).DATA1 0 0
  }
  
  for {set i 0} {$i < $NumControl} {incr i} {
	force -deposit sim:/shifter/shift_amount($i).DATA0 0 0
	force -deposit sim:/shifter/shift_amount($i).DATA1 0 0
  }
  force -deposit sim:/shifter/direction.DATA0 0 0
  force -deposit sim:/shifter/direction.DATA1 0 0
  
  force -deposit sim:/shifter/rotate.DATA0 0 0
  force -deposit sim:/shifter/rotate.DATA1 0 0
  
  force -deposit sim:/shifter/logical.DATA0 0 0
  force -deposit sim:/shifter/logical.DATA1 0 0
}

proc set_inputs { Input ShiftAmount Direction Rotate Logical } {
  global NumBits
  global NumControl
  for {set i 0} {$i < $NumBits} {incr i} {
    force -deposit sim:/shifter/inputs($i).DATA0 [expr (($Input >> $i) & 1) == 0] 0
	force -deposit sim:/shifter/inputs($i).DATA1 [expr (($Input >> $i) & 1) == 1] 0
  }
  
  for {set i 0} {$i < $NumControl} {incr i} {
	force -deposit sim:/shifter/shift_amount($i).DATA0 [expr (($ShiftAmount >> $i) & 1) == 0] 0
	force -deposit sim:/shifter/shift_amount($i).DATA1 [expr (($ShiftAmount >> $i) & 1) == 1] 0
  }
  force -deposit sim:/shifter/direction.DATA0 [expr $Direction == 0] 0
  force -deposit sim:/shifter/direction.DATA1 [expr $Direction == 1] 0
  
  force -deposit sim:/shifter/rotate.DATA0 [expr $Rotate == 0] 0
  force -deposit sim:/shifter/rotate.DATA1 [expr $Rotate == 1] 0
  
  force -deposit sim:/shifter/logical.DATA0 [expr $Logical == 0] 0
  force -deposit sim:/shifter/logical.DATA1 [expr $Logical == 1] 0
}

WaveRestoreZoom {0 ns} {150 ns}

null_inputs
run 10
set_inputs 1 0 0 0 0
run 10
null_inputs
run 10
set_inputs 1 1 0 0 0
run 10
null_inputs
run 10
set_inputs 1 2 0 0 0
run 10
null_inputs
run 10
set_inputs 1 3 0 0 0
run 10
null_inputs
run 10
set_inputs 1 0 1 0 0
run 10

null_inputs
run 10
set_inputs 1 0 1 0 0
run 10
null_inputs
run 10
set_inputs 1 1 1 0 0
run 10
null_inputs
run 10
set_inputs 1 2 1 0 0
run 10
null_inputs
run 10
set_inputs 1 3 1 0 0
run 10

null_inputs
run 10
set_inputs 1 0 0 1 0
run 10
null_inputs
run 10
set_inputs 1 1 0 1 0
run 10
null_inputs
run 10
set_inputs 1 2 0 1 0
run 10
null_inputs
run 10
set_inputs 1 3 0 1 0
run 10

null_inputs
run 10
set_inputs 3 0 0 1 0
run 10
null_inputs
run 10
set_inputs 3 1 0 1 0
run 10
null_inputs
run 10
set_inputs 3 2 0 1 0
run 10
null_inputs
run 10
set_inputs 3 3 0 1 0
run 10

null_inputs
run 10
set_inputs 3 0 1 1 0
run 10
null_inputs
run 10
set_inputs 3 1 1 1 0
run 10
null_inputs
run 10
set_inputs 3 2 1 1 0
run 10
null_inputs
run 10
set_inputs 3 3 1 1 0
run 10
null_inputs
run 10

set_inputs 7 0 0 0 0
run 10
null_inputs
run 10
set_inputs 7 1 0 0 0
run 10
null_inputs
run 10
set_inputs 7 2 0 0 0
run 10
null_inputs
run 10
set_inputs 7 3 0 0 0
run 10

null_inputs
run 10
set_inputs 7 0 1 0 0
run 10
null_inputs
run 10
set_inputs 7 1 1 0 0
run 10
null_inputs
run 10
set_inputs 7 2 1 0 0
run 10
null_inputs
run 10
set_inputs 7 3 1 0 0
run 10
null_inputs
run 10

set_inputs 7 0 0 0 1
run 10
null_inputs
run 10
set_inputs 7 1 0 0 1
run 10
null_inputs
run 10
set_inputs 7 2 0 0 1
run 10
null_inputs
run 10
set_inputs 7 3 0 0 1
run 10


run 10