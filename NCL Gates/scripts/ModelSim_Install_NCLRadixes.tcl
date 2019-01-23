proc hsv2rgb {h s v} {
    if {$s <= 0.0} {
	# achromatic
	set v [expr {int($v*255 )}]
    puts $v
	return [format #%02x%02x%02x $v $v $v]
    } else {
	set v [expr {double($v)}]
        if {$h >= 1.0} { set h 0.0 }
        set h [expr {6.0 * $h}]
        set f [expr {double($h) - int($h)}]
        set p [expr {int(255 * $v * (1.0 - $s))}]
        set q [expr {int(255 * $v * (1.0 - ($s * $f)))}]
        set t [expr {int(255 * $v * (1.0 - ($s * (1.0 - $f))))}]
	set v [expr {int(255 * $v)}]
        switch [expr {int($h)}] {
            0 { return [format "#%02x%02x%02x" $v $t $p] }
            1 { return [format "#%02x%02x%02x" $q $v $p] }
	    2 { return [format "#%02x%02x%02x" $p $v $t] }
	    3 { return [format "#%02x%02x%02x" $p $q $v] }
	    4 { return [format "#%02x%02x%02x" $t $p $v] }
	    5 { return [format "#%02x%02x%02x" $v $p $q] }
        }
    }
}

proc install_ncl2_radix {name color_data color_null} {
    set bodystr "\"0\" \"Null\" -color $color_null, \"1\" \"1\" -color $color_data, \"2\" \"0\" -color $color_data, \"3\" \"Invalid\" -color $color_data, -default default"
    puts $bodystr
    set rdef "radix define ${name} \{$bodystr\}"
    eval $rdef
}

install_ncl2_radix "ncl_red" [hsv2rgb 0 0.7 1] [hsv2rgb 0 0.3 0.6]
install_ncl2_radix "ncl_green" [hsv2rgb 0.33 0.7 0.8] [hsv2rgb 0.33 0.3 0.5]
install_ncl2_radix "ncl_blue" [hsv2rgb 0.6 0.6 0.9] [hsv2rgb 0.67 0.3 0.6]

proc add_ncl_wave {label path radix} {
    quietly virtual signal "(${path}.data0 & ${path}.data1 )" "${label}_virtual_concat"
    add wave -label $label -radix $radix "${label}_virtual_concat"
}