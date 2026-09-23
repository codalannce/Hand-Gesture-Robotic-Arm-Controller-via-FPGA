

set_property PACKAGE_PIN W5 [get_ports basys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports basys_clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports
basys_clk]


set_property PACKAGE_PIN J1 [get_ports {rx}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx}]


set_property PACKAGE_PIN K17 [get_ports {servo_pitch_angle}]
set_property IOSTANDARD LVCMOS33 [get_ports {servo_pitch_angle}]

set_property PACKAGE_PIN M18 [get_ports {servo_roll_angle}]
set_property IOSTANDARD LVCMOS33 [get_ports {servo_roll_angle}]

set_property PACKAGE_PIN N17 [get_ports {servo_yaw_angle}]
set_property IOSTANDARD LVCMOS33 [get_ports {servo_yaw_angle}]

