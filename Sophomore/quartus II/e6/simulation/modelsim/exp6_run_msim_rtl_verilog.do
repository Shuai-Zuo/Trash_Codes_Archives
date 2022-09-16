transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/quartus\ II/e5 {D:/quartus II/e5/exp6.v}

vlog -vlog01compat -work work +incdir+D:/quartus\ II/e6/simulation/modelsim {D:/quartus II/e6/simulation/modelsim/exp6.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiii_ver -L rtl_work -L work -voptargs="+acc"  exp6_vlg_tst

add wave *
view structure
view signals
run -all
