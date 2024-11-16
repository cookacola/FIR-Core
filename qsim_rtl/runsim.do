##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../rtl/alu.v 
vlog +acc -incr alu_testb.v 

# Run Simulator 
vsim +acc -t ps -lib work tb_alu
do waveformat.do   
run -all
