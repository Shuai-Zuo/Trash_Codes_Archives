onerror {quit -f}
vlib work
vlog -work work a31.vo
vlog -work work a31.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.a31_vlg_vec_tst
vcd file -direction a31.msim.vcd
vcd add -internal a31_vlg_vec_tst/*
vcd add -internal a31_vlg_vec_tst/i1/*
add wave /*
run -all
