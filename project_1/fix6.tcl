
# Fix 1: Correct reset domain for v_tc_0
disconnect_bd_net /rst_pixel_clk_peripheral_aresetn [get_bd_pins v_tc_0/resetn]
connect_bd_net [get_bd_pins rst_ps7_100M/peripheral_aresetn] [get_bd_pins v_tc_0/resetn]

# Fix 2: Disconnect individual pins one by one
set pins {v_tc_0/hsync_out v_tc_0/vsync_out v_tc_0/hblank_out v_tc_0/vblank_out v_tc_0/active_video_out}
foreach pin $pins {
    set net [get_bd_nets -of_objects [get_bd_pins $pin]]
    if {$net ne ""} {
        disconnect_bd_net $net [get_bd_pins $pin]
        puts "Disconnected: $pin"
    }
}

# Fix 3: Connect as interface
connect_bd_intf_net [get_bd_intf_pins v_tc_0/vtiming_out] [get_bd_intf_pins v_axi4s_vid_out_0/vtiming_in]

validate_bd_design
save_bd_design
puts "DONE"

