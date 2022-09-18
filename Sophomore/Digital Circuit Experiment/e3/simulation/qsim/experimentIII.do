onerror {quit -f}
vlib work
vlog -work work experimentIII.vo
vlog -work work experimentIII.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.experimentIII_vlg_vec_tst
vcd file -direction experimentIII.msim.vcd
vcd add -internal experimentIII_vlg_vec_tst/*
vcd add -internal experimentIII_vlg_vec_tst/i1/*
add wave /*
run -all
