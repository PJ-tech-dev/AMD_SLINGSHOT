
# Check what v_tc_1 is connected to
foreach pin [get_bd_pins v_tc_1/*] {
    set net [get_bd_nets -of_objects $pin]
    if {$net eq ""} {
        puts "UNCONNECTED: $pin"
    } else {
        puts "CONNECTED: $pin -> $net"
    }
}

