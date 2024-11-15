##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr adder.v 
vlog +acc -incr converter.v 
vlog +acc -incr multiplier.v 
vlog +acc -incr testbench.v 

# Run Simulator 
vsim +acc -t ps -lib work testbench 
do waveformat.do   
run -all
