# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "N1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N4" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N5" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N6" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N7" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N8" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N9" -parent ${Page_0}
  ipgui::add_param $IPINST -name "N10" -parent ${Page_0}
  ipgui::add_static_text $IPINST -name "Outputs" -parent ${Page_0} -text {The data outputs are connected directly to the inputs (when enabled). The status output is asserted when complete DATA is recieved, and cleared when complete NULL is recieved. The to_prev output is the inverse of the status output.}


}

proc update_PARAM_VALUE.N1 { PARAM_VALUE.N1 } {
	# Procedure called to update N1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N1 { PARAM_VALUE.N1 } {
	# Procedure called to validate N1
	return true
}

proc update_PARAM_VALUE.N10 { PARAM_VALUE.N10 } {
	# Procedure called to update N10 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N10 { PARAM_VALUE.N10 } {
	# Procedure called to validate N10
	return true
}

proc update_PARAM_VALUE.N2 { PARAM_VALUE.N2 } {
	# Procedure called to update N2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N2 { PARAM_VALUE.N2 } {
	# Procedure called to validate N2
	return true
}

proc update_PARAM_VALUE.N3 { PARAM_VALUE.N3 } {
	# Procedure called to update N3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N3 { PARAM_VALUE.N3 } {
	# Procedure called to validate N3
	return true
}

proc update_PARAM_VALUE.N4 { PARAM_VALUE.N4 } {
	# Procedure called to update N4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N4 { PARAM_VALUE.N4 } {
	# Procedure called to validate N4
	return true
}

proc update_PARAM_VALUE.N5 { PARAM_VALUE.N5 } {
	# Procedure called to update N5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N5 { PARAM_VALUE.N5 } {
	# Procedure called to validate N5
	return true
}

proc update_PARAM_VALUE.N6 { PARAM_VALUE.N6 } {
	# Procedure called to update N6 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N6 { PARAM_VALUE.N6 } {
	# Procedure called to validate N6
	return true
}

proc update_PARAM_VALUE.N7 { PARAM_VALUE.N7 } {
	# Procedure called to update N7 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N7 { PARAM_VALUE.N7 } {
	# Procedure called to validate N7
	return true
}

proc update_PARAM_VALUE.N8 { PARAM_VALUE.N8 } {
	# Procedure called to update N8 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N8 { PARAM_VALUE.N8 } {
	# Procedure called to validate N8
	return true
}

proc update_PARAM_VALUE.N9 { PARAM_VALUE.N9 } {
	# Procedure called to update N9 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N9 { PARAM_VALUE.N9 } {
	# Procedure called to validate N9
	return true
}


proc update_MODELPARAM_VALUE.N1 { MODELPARAM_VALUE.N1 PARAM_VALUE.N1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N1}] ${MODELPARAM_VALUE.N1}
}

proc update_MODELPARAM_VALUE.N2 { MODELPARAM_VALUE.N2 PARAM_VALUE.N2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N2}] ${MODELPARAM_VALUE.N2}
}

proc update_MODELPARAM_VALUE.N3 { MODELPARAM_VALUE.N3 PARAM_VALUE.N3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N3}] ${MODELPARAM_VALUE.N3}
}

proc update_MODELPARAM_VALUE.N4 { MODELPARAM_VALUE.N4 PARAM_VALUE.N4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N4}] ${MODELPARAM_VALUE.N4}
}

proc update_MODELPARAM_VALUE.N5 { MODELPARAM_VALUE.N5 PARAM_VALUE.N5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N5}] ${MODELPARAM_VALUE.N5}
}

proc update_MODELPARAM_VALUE.N6 { MODELPARAM_VALUE.N6 PARAM_VALUE.N6 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N6}] ${MODELPARAM_VALUE.N6}
}

proc update_MODELPARAM_VALUE.N7 { MODELPARAM_VALUE.N7 PARAM_VALUE.N7 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N7}] ${MODELPARAM_VALUE.N7}
}

proc update_MODELPARAM_VALUE.N8 { MODELPARAM_VALUE.N8 PARAM_VALUE.N8 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N8}] ${MODELPARAM_VALUE.N8}
}

proc update_MODELPARAM_VALUE.N9 { MODELPARAM_VALUE.N9 PARAM_VALUE.N9 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N9}] ${MODELPARAM_VALUE.N9}
}

proc update_MODELPARAM_VALUE.N10 { MODELPARAM_VALUE.N10 PARAM_VALUE.N10 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N10}] ${MODELPARAM_VALUE.N10}
}

