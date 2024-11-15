##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr /user/stud/fall23/cc4919/4823/ald-labs/Lab6/adder.v 
vlog +acc -incr /user/stud/fall23/cc4919/4823/ald-labs/Lab6/converter.v 
vlog +acc -incr /user/stud/fall23/cc4919/4823/ald-labs/Lab6/multiplier.v 
vlog +acc -incr testbench.v 

# Run Simulator 
vsim +acc -t ps -lib work testbench 
do waveformat.do   
run -all
