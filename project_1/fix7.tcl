
foreach connection {
    {clk_wiz/clk_out1 dvi2rgb_0/PixelClk}
    {clk_wiz/clk_out1 rgb2dvi_0/PixelClk}
    {ps7/FCLK_CLK0 dvi2rgb_0/RefClk}
    {rst_ps7_100M/mb_reset dvi2rgb_0/aRst}
    {rst_ps7_100M/mb_reset dvi2rgb_0/pRst}
    {clk_wiz/locked dvi2rgb_0/aPixelClkLckd}
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

