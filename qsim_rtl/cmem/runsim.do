##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr /user/stud/fall23/ns3683/4823/ald-labs/rtl/cmem/cmem.v
vlog +acc -incr cmem_tb.v
vlog +acc -incr /user/stud/fall23/ns3683/4823/ald-labs/mem_comp/RF1SHD.v 

# Run Simulator 
vsim +acc -t ps -lib work cmem_tb
do waveformat.do   
run -all
