onerror {quit -f}
vlib work
vlog -work work exp8.vo
vlog -work work exp8.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.exp8_top_vlg_vec_tst
vcd file -direction exp8.msim.vcd
vcd add -internal exp8_top_vlg_vec_tst/*
vcd add -internal exp8_top_vlg_vec_tst/i1/*
add wave /*
run -all
