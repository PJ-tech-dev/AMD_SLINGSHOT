
foreach connection {
    {clk_wiz/clk_out1 rgb2dvi_0/PixelClk}
    {clk_wiz/clk_out1 v_axi4s_vid_out_0/aclk}
    {v_tc_0/vtiming_out v_axi4s_vid_out_0/vtiming_in}
    {rst_ps7_100M/peripheral_aresetn v_tc_0/resetn}
    {rst_ps7_100M/peripheral_aresetn v_tc_1/resetn}
    {ps7/FCLK_CLK0 dvi2rgb_0/RefClk}
    {rst_ps7_100M/mb_reset dvi2rgb_0/aRst}
    {rst_ps7_100M/mb_reset dvi2rgb_0/pRst}
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

