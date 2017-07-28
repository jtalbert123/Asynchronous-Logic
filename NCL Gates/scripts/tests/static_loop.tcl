set NumStages 3

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
  set color [hsv2rgb [expr ($stage + 0.0)/$NumStages] 1 0.8]
  set bodystr "\"0\" \"Null\" -color $color, \"1\" \"1\" -color $color, \"2\" \"0\" -color $color, \"3\" \"Invalid\" -color $color, -default default"
  set rdef "radix define ncl_pair_${stage} \{$bodystr\}"
  eval $rdef

  quietly virtual signal -install sim:/static_loop " (context sim:/static_loop )(stages($stage)(0).data0 & stages($stage)(0).data1 )" "s${stage}0_virt"
  quietly virtual signal -install sim:/static_loop " (context sim:/static_loop )(stages($stage)(1).data0 & stages($stage)(1).data1 )" "s${stage}1_virt"

  add wave -noupdate -divider "Stage $stage"
  add wave -label "to_prev" -color $color sim:/static_loop/controls($stage)
  add wave -label "Stage${stage}.A" -color $color -radix ncl_pair_${stage} "sim:/static_loop/s${stage}0_virt"
  add wave -label "Stage${stage}.B" -color $color -radix ncl_pair_${stage} "sim:/static_loop/s${stage}1_virt"
  add wave -label "from_next" -color $color sim:/static_loop/controls([expr ($stage+1) % $NumStages])
}

force -freeze sim:/static_loop/stages(0)(0).data0 1 0
force -freeze sim:/static_loop/stages(0)(1).data1 1 0
run 100
noforce sim:/static_loop/stages(0)(0).data0
noforce sim:/static_loop/stages(0)(1).data1

run 1000