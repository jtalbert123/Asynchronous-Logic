# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  #Adding Group
  set Horizontal [ipgui::add_group $IPINST -name "Horizontal" -parent ${Page_0} -layout horizontal]
  #Adding Group
  set Register_Settings [ipgui::add_group $IPINST -name "Register Settings" -parent ${Horizontal} -display_name {Data Widths}]
  set N1 [ipgui::add_param $IPINST -name "N1" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 1. Set to 0 to disable} ${N1}
  set N2 [ipgui::add_param $IPINST -name "N2" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 2. Set to 0 to disable} ${N2}
  set N3 [ipgui::add_param $IPINST -name "N3" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 3. Set to 0 to disable} ${N3}
  set N4 [ipgui::add_param $IPINST -name "N4" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 4. Set to 0 to disable} ${N4}
  set N5 [ipgui::add_param $IPINST -name "N5" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 5. Set to 0 to disable} ${N5}
  set N6 [ipgui::add_param $IPINST -name "N6" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 5. Set to 0 to disable} ${N6}
  set N7 [ipgui::add_param $IPINST -name "N7" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 7. Set to 0 to disable} ${N7}
  set N8 [ipgui::add_param $IPINST -name "N8" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 8. Set to 0 to disable} ${N8}
  set N9 [ipgui::add_param $IPINST -name "N9" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 9. Set to 0 to disable} ${N9}
  set N10 [ipgui::add_param $IPINST -name "N10" -parent ${Register_Settings}]
  set_property tooltip {The number of bits in channel 10. Set to 0 to disable} ${N10}

  #Adding Group
  set Resets [ipgui::add_group $IPINST -name "Resets" -parent ${Horizontal}]
  set_property tooltip {Reset values only active if set to reset to DATA.} ${Resets}
  set reset_to_data [ipgui::add_param $IPINST -name "reset_to_data" -parent ${Resets}]
  set_property tooltip {Checked: When reset is asserted, output DATA (value given below)} ${reset_to_data}
  ipgui::add_param $IPINST -name "PORT1_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT2_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT9_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT8_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT7_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT6_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT5_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT4_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT3_RESET_VAL" -parent ${Resets}
  ipgui::add_param $IPINST -name "PORT10_RESET_VAL" -parent ${Resets}




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

proc update_PARAM_VALUE.PORT10_RESET_VAL { PARAM_VALUE.PORT10_RESET_VAL } {
	# Procedure called to update PORT10_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT10_RESET_VAL { PARAM_VALUE.PORT10_RESET_VAL } {
	# Procedure called to validate PORT10_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT1_RESET_VAL { PARAM_VALUE.PORT1_RESET_VAL } {
	# Procedure called to update PORT1_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT1_RESET_VAL { PARAM_VALUE.PORT1_RESET_VAL } {
	# Procedure called to validate PORT1_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT2_RESET_VAL { PARAM_VALUE.PORT2_RESET_VAL } {
	# Procedure called to update PORT2_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT2_RESET_VAL { PARAM_VALUE.PORT2_RESET_VAL } {
	# Procedure called to validate PORT2_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT3_RESET_VAL { PARAM_VALUE.PORT3_RESET_VAL } {
	# Procedure called to update PORT3_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT3_RESET_VAL { PARAM_VALUE.PORT3_RESET_VAL } {
	# Procedure called to validate PORT3_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT4_RESET_VAL { PARAM_VALUE.PORT4_RESET_VAL } {
	# Procedure called to update PORT4_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT4_RESET_VAL { PARAM_VALUE.PORT4_RESET_VAL } {
	# Procedure called to validate PORT4_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT5_RESET_VAL { PARAM_VALUE.PORT5_RESET_VAL } {
	# Procedure called to update PORT5_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT5_RESET_VAL { PARAM_VALUE.PORT5_RESET_VAL } {
	# Procedure called to validate PORT5_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT6_RESET_VAL { PARAM_VALUE.PORT6_RESET_VAL } {
	# Procedure called to update PORT6_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT6_RESET_VAL { PARAM_VALUE.PORT6_RESET_VAL } {
	# Procedure called to validate PORT6_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT7_RESET_VAL { PARAM_VALUE.PORT7_RESET_VAL } {
	# Procedure called to update PORT7_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT7_RESET_VAL { PARAM_VALUE.PORT7_RESET_VAL } {
	# Procedure called to validate PORT7_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT8_RESET_VAL { PARAM_VALUE.PORT8_RESET_VAL } {
	# Procedure called to update PORT8_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT8_RESET_VAL { PARAM_VALUE.PORT8_RESET_VAL } {
	# Procedure called to validate PORT8_RESET_VAL
	return true
}

proc update_PARAM_VALUE.PORT9_RESET_VAL { PARAM_VALUE.PORT9_RESET_VAL } {
	# Procedure called to update PORT9_RESET_VAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PORT9_RESET_VAL { PARAM_VALUE.PORT9_RESET_VAL } {
	# Procedure called to validate PORT9_RESET_VAL
	return true
}

proc update_PARAM_VALUE.reset_to_data { PARAM_VALUE.reset_to_data } {
	# Procedure called to update reset_to_data when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.reset_to_data { PARAM_VALUE.reset_to_data } {
	# Procedure called to validate reset_to_data
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

proc update_MODELPARAM_VALUE.reset_to_data { MODELPARAM_VALUE.reset_to_data PARAM_VALUE.reset_to_data } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.reset_to_data}] ${MODELPARAM_VALUE.reset_to_data}
}

proc update_MODELPARAM_VALUE.PORT1_RESET_VAL { MODELPARAM_VALUE.PORT1_RESET_VAL PARAM_VALUE.PORT1_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT1_RESET_VAL}] ${MODELPARAM_VALUE.PORT1_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT2_RESET_VAL { MODELPARAM_VALUE.PORT2_RESET_VAL PARAM_VALUE.PORT2_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT2_RESET_VAL}] ${MODELPARAM_VALUE.PORT2_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT3_RESET_VAL { MODELPARAM_VALUE.PORT3_RESET_VAL PARAM_VALUE.PORT3_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT3_RESET_VAL}] ${MODELPARAM_VALUE.PORT3_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT4_RESET_VAL { MODELPARAM_VALUE.PORT4_RESET_VAL PARAM_VALUE.PORT4_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT4_RESET_VAL}] ${MODELPARAM_VALUE.PORT4_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT5_RESET_VAL { MODELPARAM_VALUE.PORT5_RESET_VAL PARAM_VALUE.PORT5_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT5_RESET_VAL}] ${MODELPARAM_VALUE.PORT5_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT6_RESET_VAL { MODELPARAM_VALUE.PORT6_RESET_VAL PARAM_VALUE.PORT6_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT6_RESET_VAL}] ${MODELPARAM_VALUE.PORT6_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT7_RESET_VAL { MODELPARAM_VALUE.PORT7_RESET_VAL PARAM_VALUE.PORT7_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT7_RESET_VAL}] ${MODELPARAM_VALUE.PORT7_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT8_RESET_VAL { MODELPARAM_VALUE.PORT8_RESET_VAL PARAM_VALUE.PORT8_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT8_RESET_VAL}] ${MODELPARAM_VALUE.PORT8_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT9_RESET_VAL { MODELPARAM_VALUE.PORT9_RESET_VAL PARAM_VALUE.PORT9_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT9_RESET_VAL}] ${MODELPARAM_VALUE.PORT9_RESET_VAL}
}

proc update_MODELPARAM_VALUE.PORT10_RESET_VAL { MODELPARAM_VALUE.PORT10_RESET_VAL PARAM_VALUE.PORT10_RESET_VAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PORT10_RESET_VAL}] ${MODELPARAM_VALUE.PORT10_RESET_VAL}
}

