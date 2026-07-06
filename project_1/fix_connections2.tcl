
foreach connection {
    {ps7/FCLK_CLK0 rst_ps7_100M/slowest_sync_clk}
    {ps7/FCLK_CLK0 ps7/M_AXI_GP0_ACLK}
    {ps7/FCLK_CLK0 ps7/S_AXI_HP0_ACLK}
    {ps7/FCLK_CLK0 ps7_axi_periph/ACLK}
    {ps7/FCLK_CLK0 ps7_axi_periph/S00_ACLK}
    {ps7/FCLK_CLK0 ps7_axi_periph/M00_ACLK}
    {ps7/FCLK_CLK0 ps7_axi_periph/M01_ACLK}
    {ps7/FCLK_CLK0 ps7_axi_periph/M02_ACLK}
    {ps7/FCLK_CLK0 ps7_axi_periph/M03_ACLK}
    {ps7/FCLK_CLK0 ps7_axi_periph/M04_ACLK}
    {ps7/FCLK_CLK0 axi_mem_intercon/ACLK}
    {ps7/FCLK_CLK0 axi_mem_intercon/S00_ACLK}
    {ps7/FCLK_CLK0 axi_mem_intercon/S01_ACLK}
    {ps7/FCLK_CLK0 axi_mem_intercon/M00_ACLK}
    {ps7/FCLK_CLK0 vdma/s_axi_lite_aclk}
    {ps7/FCLK_CLK0 vdma/m_axi_mm2s_aclk}
    {ps7/FCLK_CLK0 vdma/m_axi_s2mm_aclk}
    {ps7/FCLK_CLK0 vdma/m_axis_mm2s_aclk}
    {ps7/FCLK_CLK0 vdma/s_axis_s2mm_aclk}
    {ps7/FCLK_CLK0 clk_wiz/clk_in1}
    {ps7/FCLK_CLK0 v_tc_0/s_axi_aclk}
    {ps7/FCLK_CLK0 v_tc_1/s_axi_aclk}
    {ps7/FCLK_CLK0 v_tpg_0/ap_clk}
    {ps7/FCLK_CLK0 wafer_video_0/ap_clk}
    {clk_wiz/clk_out1 v_tc_0/clk}
    {clk_wiz/clk_out1 v_tc_1/clk}
    {clk_wiz/clk_out1 v_axi4s_vid_out_0/aclk}
    {ps7/FCLK_RESET0_N rst_ps7_100M/ext_reset_in}
    {clk_wiz/locked rst_ps7_100M/dcm_locked}
    {rst_ps7_100M/peripheral_aresetn ps7_axi_periph/ARESETN}
    {rst_ps7_100M/peripheral_aresetn ps7_axi_periph/S00_ARESETN}
    {rst_ps7_100M/peripheral_aresetn ps7_axi_periph/M00_ARESETN}
    {rst_ps7_100M/peripheral_aresetn ps7_axi_periph/M01_ARESETN}
    {rst_ps7_100M/peripheral_aresetn ps7_axi_periph/M02_ARESETN}
    {rst_ps7_100M/peripheral_aresetn ps7_axi_periph/M03_ARESETN}
    {rst_ps7_100M/peripheral_aresetn ps7_axi_periph/M04_ARESETN}
    {rst_ps7_100M/peripheral_aresetn axi_mem_intercon/ARESETN}
    {rst_ps7_100M/peripheral_aresetn axi_mem_intercon/S00_ARESETN}
    {rst_ps7_100M/peripheral_aresetn axi_mem_intercon/S01_ARESETN}
    {rst_ps7_100M/peripheral_aresetn axi_mem_intercon/M00_ARESETN}
    {rst_ps7_100M/peripheral_aresetn vdma/axi_resetn}
    {rst_ps7_100M/peripheral_aresetn v_tc_0/s_axi_aresetn}
    {rst_ps7_100M/peripheral_aresetn v_tc_1/s_axi_aresetn}
    {rst_ps7_100M/peripheral_aresetn v_axi4s_vid_out_0/aresetn}
    {rst_ps7_100M/peripheral_aresetn wafer_video_0/ap_rst_n}
    {rst_ps7_100M/peripheral_aresetn v_tpg_0/ap_rst_n}
    {rst_ps7_100M/mb_reset rgb2dvi_0/aRst}
    {rst_ps7_100M/mb_reset clk_wiz/reset}
} {
    set src [lindex $connection 0]
    set dst [lindex $connection 1]
    catch {
        connect_bd_net [get_bd_pins $src] [get_bd_pins $dst]
        puts "OK: $src -> $dst"
    } err
    if {$err ne ""} { puts "SKIP: $dst ($err)" }
}
validate_bd_design
save_bd_design
puts "DONE"

