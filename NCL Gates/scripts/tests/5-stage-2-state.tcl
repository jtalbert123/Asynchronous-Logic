set NumStages 5

proc hsv2rgb {h s v} {
    if {$s <= 0.0} {
	# achromatic
	set v [expr {int($v)}]
	return "$v $v $v"
    } else {
	set v [expr {double($v)}]
        if {$h >= 1.0} { set h 0.0 }
        set h [expr {6.0 * $h}]
        set f [expr {double($h) - int($h)}]
        set p [expr {int(256 * $v * (1.0 - $s))}]
        set q [expr {int(256 * $v * (1.0 - ($s * $f)))}]
        set t [expr {int(256 * $v * (1.0 - ($s * (1.0 - $f))))}]
	set v [expr {int(256 * $v)}]
        switch [expr {int($h)}] {
            0 { return [format #%02x%02x%02x $v $t $p] }
            1 { return [format #%02x%02x%02x $q $v $p] }
	    2 { return [format #%02x%02x%02x $p $v $t] }
	    3 { return [format #%02x%02x%02x $p $q $v] }
	    4 { return [format #%02x%02x%02x $t $p $v] }
	    5 { return [format #%02x%02x%02x $v $p $q] }
        }
    }
}

vcom -O1 -lint -quiet -check_synthesis -work work ncl/ncl.vhd ncl/impl.vhd ncl/components/Register.vhd ncl/tests/static_loop.vhd
view wave
delete wave *
vsim -gui work.static_loop -gNumStages=$NumStages

for {set stage 0} {$stage < $NumStages} {incr stage} {
  set color [hsv2rgb [expr ($stage + 0.0)/$NumStages] 0.7 0.8]
  set bodystr "\"0\" \"Null\" -color $color, \"1\" \"1\" -color $color, \"2\" \"0\" -color $color, \"3\" \"Invalid\" -color $color, -default default"
  set rdef "radix define ncl_pair_${stage} \{$bodystr\}"
  eval $rdef

  quietly virtual signal -install sim:/static_loop " (context sim:/static_loop/stage($stage)/stageRegister )(inputs(0).data0 & inputs(0).data1 )" "si${stage}0_virt"
  quietly virtual signal -install sim:/static_loop " (context sim:/static_loop/stage($stage)/stageRegister )(inputs(1).data0 & inputs(1).data1 )" "si${stage}1_virt"

  quietly virtual signal -install sim:/static_loop " (context sim:/static_loop/stage($stage)/stageRegister )(output(0).data0 & output(0).data1 )" "so${stage}0_virt"
  quietly virtual signal -install sim:/static_loop " (context sim:/static_loop/stage($stage)/stageRegister )(output(1).data0 & output(1).data1 )" "so${stage}1_virt"

  add wave -noupdate -divider "Stage $stage"
#  add wave -label "Stage${stage}.iA" -color $color -radix ncl_pair_${stage} "sim:/static_loop/si${stage}0_virt"
#  add wave -label "Stage${stage}.iB" -color $color -radix ncl_pair_${stage} "sim:/static_loop/si${stage}1_virt"
  add wave -label "from_next" -color $color sim:/static_loop/stage($stage)/stageRegister/from_next
  add wave -label "Stage${stage}.oA" -color $color -radix ncl_pair_${stage} "sim:/static_loop/so${stage}0_virt"
  add wave -label "Stage${stage}.oB" -color $color -radix ncl_pair_${stage} "sim:/static_loop/so${stage}1_virt"
  add wave -label "to_prev" -color $color sim:/static_loop/stage($stage)/stageRegister/to_prev

  add log sim:/static_loop/stage($stage)/stageRegister/watcher/*
  add log sim:/static_loop/stage($stage)/stageRegister/*
  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i0/*
  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i1/*
  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i0/*
  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i1/*

  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i0/Delay
  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i1/Delay
  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i0/Delay
  add log sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i1/Delay
}

configure wave -namecolwidth 100
configure wave -valuecolwidth 40
WaveRestoreZoom {0 ns} {1000 ns}
run 0

proc setStageToData {stage val} {
  set d0_0 [expr ($val & 1) == 0]
  set d0_1 [expr ($val & 1) == 1]

  set d1_0 [expr (($val >> 1) & 1) == 0]
  set d1_1 [expr (($val >> 1) & 1) == 1]
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i0/sOut $d0_0 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i0/output $d0_0 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i1/sOut $d0_1 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(0)/T22_i1/output $d0_1 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i0/sOut $d1_0 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i0/output $d1_0 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i1/sOut $d1_1 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/register_gates(1)/T22_i1/output $d1_1 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/watcher/sOut 1 0
  force -deposit sim:/static_loop/stage($stage)/stageRegister/watcher/output 1 0
}

setStageToData 0 0
setStageToData 2 3
run 1000
