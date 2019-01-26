# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set NBITS [ipgui::add_param $IPINST -name "NBITS" -parent ${Page_0}]
  set_property tooltip {The number of bits in the NCL dual-rail signal} ${NBITS}
  ipgui::add_param $IPINST -name "PORTS" -parent ${Page_0}


}

proc update_PARAM_VALUE.NBITS { PARAM_VALUE.NBITS } {
	# Procedure called to update NBITS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NBITS { PARAM_VALUE.NBITS } {
	# Procedure called to validate NBITS
	return true
}

proc update_PARAM_VALUE.PORTS { PARAM_VALUE.PORTS } {
	# Procedure called to update PORTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORTS { PARAM_VALUE.PORTS } {
	# Procedure called to validate PORTS
	return true
}


proc update_MODELPARAM_VALUE.NBITS { MODELPARAM_VALUE.NBITS PARAM_VALUE.NBITS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NBITS}] ${MODELPARAM_VALUE.NBITS}
}

proc update_MODELPARAM_VALUE.PORTS { MODELPARAM_VALUE.PORTS PARAM_VALUE.PORTS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORTS}] ${MODELPARAM_VALUE.PORTS}
}

