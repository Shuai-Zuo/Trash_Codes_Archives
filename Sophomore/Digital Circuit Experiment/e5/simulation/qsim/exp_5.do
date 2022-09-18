onerror {quit -f}
vlib work
vlog -work work exp_5.vo
vlog -work work exp_5.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.exp_5_vlg_vec_tst
vcd file -direction exp_5.msim.vcd
vcd add -internal exp_5_vlg_vec_tst/*
vcd add -internal exp_5_vlg_vec_tst/i1/*
add wave /*
run -all
