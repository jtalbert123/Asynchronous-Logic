set module t22
source scripts/tests/setup.tcl

add wave -radix hexadecimal -label "in" -color $input_color sim:/${module}_tb/inputs
add wave -radix hexadecimal -label "out" -color $output_color sim:/${module}_tb/outputs

source scripts/tests/run_tb.tcl