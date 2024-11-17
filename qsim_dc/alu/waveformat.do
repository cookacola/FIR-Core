onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_alu/clk
add wave -noupdate /tb_alu/rst
add wave -noupdate /tb_alu/select
add wave -noupdate /test_alu/a
add wave -noupdate /test_alu/b
add wave -noupdate -radix unsigned /tb_alu/alu_out
add wave -noupdate -radix unsigned /tb_alu/matlab_out_sum_file
add wave -noupdate -radix unsigned /tb_alu/matlab_out_prod_file
add wave -noupdate /tb_alu/qsim_out_file
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {10 ns}
