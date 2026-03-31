create_clock -period 20 -name clk [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN N18 [get_ports clk]


set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN P19 [get_ports rst_n]


set_property IOSTANDARD LVCMOS33 [get_ports DC]
set_property IOSTANDARD LVCMOS33 [get_ports SCL]
set_property IOSTANDARD LVCMOS33 [get_ports SDA]
set_property IOSTANDARD LVCMOS33 [get_ports nRES]

set_property PACKAGE_PIN R18 [get_ports DC]
set_property PACKAGE_PIN R19 [get_ports SCL]
set_property PACKAGE_PIN P20 [get_ports SDA]
set_property PACKAGE_PIN N17 [get_ports nRES]


set_property IOSTANDARD LVCMOS33 [get_ports speaker_out]
set_property PACKAGE_PIN D18 [get_ports speaker_out]



set_property IOSTANDARD LVCMOS33 [get_ports btn1]
set_property IOSTANDARD LVCMOS33 [get_ports btn2]
set_property IOSTANDARD LVCMOS33 [get_ports btn3]


set_property PACKAGE_PIN U19 [get_ports btn1]
set_property PACKAGE_PIN U20 [get_ports btn2]
set_property PACKAGE_PIN T19 [get_ports btn3]
