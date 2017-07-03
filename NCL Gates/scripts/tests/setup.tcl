set input_color #FF0000
set output_color #0000FF

view wave
delete wave *
vcom -work work ncl/ncl.vhd ncl/impl.vhd ncl/tests/${module}_tb.vhd
vsim -gui work.${module}_tb