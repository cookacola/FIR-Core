onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cmem_tb/i
add wave -noupdate /cmem_tb/clk
add wave -noupdate /cmem_tb/CEN
add wave -noupdate /cmem_tb/WEN
add wave -noupdate -radix decimal /cmem_tb/D
add wave -noupdate -radix unsigned /cmem_tb/Q7
add wave -noupdate -radix unsigned /cmem_tb/Q6
add wave -noupdate -radix unsigned /cmem_tb/Q5
add wave -noupdate -radix unsigned /cmem_tb/Q4
add wave -noupdate -radix unsigned /cmem_tb/Q3
add wave -noupdate -radix unsigned /cmem_tb/Q2
add wave -noupdate -radix unsigned /cmem_tb/Q1
add wave -noupdate -radix unsigned /cmem_tb/Q0
add wave -noupdate -radix unsigned /cmem_tb/A7
add wave -noupdate -radix unsigned /cmem_tb/A6
add wave -noupdate -radix unsigned /cmem_tb/A5
add wave -noupdate -radix unsigned /cmem_tb/A4
add wave -noupdate -radix unsigned /cmem_tb/A3
add wave -noupdate -radix unsigned /cmem_tb/A2
add wave -noupdate -radix unsigned /cmem_tb/A1
add wave -noupdate -radix unsigned /cmem_tb/A0
add wave -noupdate -radix decimal /cmem_tb/Q
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
WaveRestoreZoom {0 ns} {12 ns}
