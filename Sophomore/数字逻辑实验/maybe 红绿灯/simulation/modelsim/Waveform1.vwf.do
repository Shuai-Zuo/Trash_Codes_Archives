vlog -work work G:/aq1/simulation/modelsim/Waveform1.vwf.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.red_vlg_vec_tst
onerror {resume}
add wave {red_vlg_vec_tst/i1/clk}
add wave {red_vlg_vec_tst/i1/gre}
add wave {red_vlg_vec_tst/i1/gre[5]}
add wave {red_vlg_vec_tst/i1/gre[4]}
add wave {red_vlg_vec_tst/i1/gre[3]}
add wave {red_vlg_vec_tst/i1/gre[2]}
add wave {red_vlg_vec_tst/i1/gre[1]}
add wave {red_vlg_vec_tst/i1/gre[0]}
add wave {red_vlg_vec_tst/i1/out}
add wave {red_vlg_vec_tst/i1/out[1]}
add wave {red_vlg_vec_tst/i1/out[0]}
add wave {red_vlg_vec_tst/i1/red}
add wave {red_vlg_vec_tst/i1/red[5]}
add wave {red_vlg_vec_tst/i1/red[4]}
add wave {red_vlg_vec_tst/i1/red[3]}
add wave {red_vlg_vec_tst/i1/red[2]}
add wave {red_vlg_vec_tst/i1/red[1]}
add wave {red_vlg_vec_tst/i1/red[0]}
add wave {red_vlg_vec_tst/i1/reset}
add wave {red_vlg_vec_tst/i1/yel}
add wave {red_vlg_vec_tst/i1/yel[5]}
add wave {red_vlg_vec_tst/i1/yel[4]}
add wave {red_vlg_vec_tst/i1/yel[3]}
add wave {red_vlg_vec_tst/i1/yel[2]}
add wave {red_vlg_vec_tst/i1/yel[1]}
add wave {red_vlg_vec_tst/i1/yel[0]}
add wave {red_vlg_vec_tst/i1/pin_name1}
run -all
