
foreach connection {
    {v_tc_0/hsync_out v_axi4s_vid_out_0/vtg_hsync}
    {v_tc_0/vsync_out v_axi4s_vid_out_0/vtg_vsync}
    {v_tc_0/hblank_out v_axi4s_vid_out_0/vtg_hblank}
    {v_tc_0/vblank_out v_axi4s_vid_out_0/vtg_vblank}
    {v_tc_0/active_video_out v_axi4s_vid_out_0/vtg_active_video}
    {v_tc_0/fsync_out v_axi4s_vid_out_0/vtg_field_id}
    {v_axi4s_vid_out_0/vtg_ce v_tc_0/gen_clken}
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

