onerror {quit -f}
vlib work
vlog -work work red.vo
vlog -work work red.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.redw_vlg_vec_tst
vcd file -direction red.msim.vcd
vcd add -internal redw_vlg_vec_tst/*
vcd add -internal redw_vlg_vec_tst/i1/*
add wave /*
run -all
