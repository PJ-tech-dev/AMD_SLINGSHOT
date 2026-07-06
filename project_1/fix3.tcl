
# Add second reset module for pixel clock domain
create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_pixel_clk

# Connect new reset to pixel clock
foreach connection {
    {clk_wiz/clk_out1 rst_pixel_clk/slowest_sync_clk}
    {clk_wiz/locked rst_pixel_clk/dcm_locked}
    {ps7/FCLK_RESET0_N rst_pixel_clk/ext_reset_in}
    {rst_pixel_clk/peripheral_aresetn v_tc_0/resetn}
    {rst_pixel_clk/peripheral_aresetn v_tc_1/resetn}
    {rst_pixel_clk/peripheral_aresetn v_axi4s_vid_out_0/aresetn}
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

