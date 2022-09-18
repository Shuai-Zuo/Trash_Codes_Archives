onerror {quit -f}
vlib work
vlog -work work Elevator_Controller.vo
vlog -work work Elevator_Controller.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.floor_vlg_vec_tst
vcd file -direction Elevator_Controller.msim.vcd
vcd add -internal floor_vlg_vec_tst/*
vcd add -internal floor_vlg_vec_tst/i1/*
add wave /*
run -all
