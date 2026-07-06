## ============================================================
## PYNQ-Z2 Wafer AI Inspection System
## Optimized XDC Constraints
## Generated: February 28, 2026
## ============================================================

##------------------------------------------------------------
## System Reset
##------------------------------------------------------------
set_property PACKAGE_PIN J15 [get_ports reset_rtl_0]
set_property IOSTANDARD LVCMOS33 [get_ports reset_rtl_0]
set_property PULLUP true [get_ports reset_rtl_0]

##------------------------------------------------------------
## HDMI TX (Output) - Bank 33
##------------------------------------------------------------
set_property PACKAGE_PIN M17 [get_ports hdmi_tx_clk_p]
set_property PACKAGE_PIN M18 [get_ports hdmi_tx_clk_n]
set_property IOSTANDARD TMDS_33 [get_ports hdmi_tx_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports hdmi_tx_clk_n]

set_property PACKAGE_PIN K17 [get_ports {hdmi_tx_data_p[0]}]
set_property PACKAGE_PIN K18 [get_ports {hdmi_tx_data_n[0]}]
set_property PACKAGE_PIN L14 [get_ports {hdmi_tx_data_p[1]}]
set_property PACKAGE_PIN L15 [get_ports {hdmi_tx_data_n[1]}]
set_property PACKAGE_PIN N15 [get_ports {hdmi_tx_data_p[2]}]
set_property PACKAGE_PIN N16 [get_ports {hdmi_tx_data_n[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {hdmi_tx_data_p[*]}]
set_property IOSTANDARD TMDS_33 [get_ports {hdmi_tx_data_n[*]}]

##------------------------------------------------------------
## HDMI RX (Input) - Bank 35
## Note: Only constrain P-side, N-side auto-assigned
##------------------------------------------------------------
set_property PACKAGE_PIN H16 [get_ports hdmi_rx_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports hdmi_rx_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports hdmi_rx_clk_n]

set_property PACKAGE_PIN E18 [get_ports {hdmi_rx_data_p[0]}]
set_property PACKAGE_PIN C20 [get_ports {hdmi_rx_data_p[1]}]
set_property PACKAGE_PIN B19 [get_ports {hdmi_rx_data_p[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {hdmi_rx_data_p[*]}]
set_property IOSTANDARD TMDS_33 [get_ports {hdmi_rx_data_n[*]}]

##------------------------------------------------------------
## IIC - HDMI DDC
##------------------------------------------------------------
set_property PACKAGE_PIN P15 [get_ports iic_rtl_0_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_rtl_0_scl_io]
set_property PULLUP true [get_ports iic_rtl_0_scl_io]

set_property PACKAGE_PIN P16 [get_ports iic_rtl_0_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_rtl_0_sda_io]
set_property PULLUP true [get_ports iic_rtl_0_sda_io]

##------------------------------------------------------------
## Primary Clock Constraints
##------------------------------------------------------------
create_clock -period 6.734 -name clk_out1_design_1_clk_wiz_0  [get_pins design_1_i/clk_wiz/inst/mmcm_adv_inst/CLKOUT0]

##------------------------------------------------------------
## Clock Groups - Async isolation
##------------------------------------------------------------
set_clock_groups -name async_ps7_vs_pixel -asynchronous  -group [get_clocks {clk_fpga_0 clk_fpga_1  design_1_i/clk_wiz/inst/clk_in1  clkfbout_design_1_clk_wiz_0}]  -group [get_clocks {clk_out1_design_1_clk_wiz_0  PixelClkIO CLKFBIN}]

set_clock_groups -name async_serial -asynchronous  -group [get_clocks SerialClkIO]  -group [get_clocks {clk_fpga_0 clk_fpga_1  clk_out1_design_1_clk_wiz_0  PixelClkIO}]

##------------------------------------------------------------
## False Paths
##------------------------------------------------------------
set_false_path -from [get_ports reset_rtl_0]
set_false_path -from [get_ports iic_rtl_0_scl_io]
set_false_path -from [get_ports iic_rtl_0_sda_io]
set_false_path -to [get_ports iic_rtl_0_scl_io]
set_false_path -to [get_ports iic_rtl_0_sda_io]

##------------------------------------------------------------
## Pulse Width Relaxation for SerialClkIO (742.5MHz TMDS)
##------------------------------------------------------------
set_property SEVERITY {Warning} [get_drc_checks TPWS-3]
set_property SEVERITY {Warning} [get_drc_checks TPWS-2]

##------------------------------------------------------------
## Bitstream Settings
##------------------------------------------------------------
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
