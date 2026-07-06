
disconnect_bd_net /rst_ps7_100M_peripheral_aresetn [get_bd_pins v_tc_0/resetn]
disconnect_bd_net /rst_ps7_100M_peripheral_aresetn [get_bd_pins v_tc_1/resetn]
disconnect_bd_net /rst_ps7_100M_peripheral_aresetn [get_bd_pins v_axi4s_vid_out_0/aresetn]

foreach connection {
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

