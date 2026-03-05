proc compile {top} {

    puts "Closing any open project..."
    close_project -quiet


    puts "Reading Verilog files..."
    if {[glob -nocomplain *.v] != ""} {
        read_verilog [glob *.v]
    }

    puts "Reading SystemVerilog files..."
    if {[glob -nocomplain *.sv] != ""} {
        read_verilog -sv [glob *.sv]
    }

    puts "Reading constraints..."
    if {[file exists "$top.xdc"]} {
        read_xdc $top.xdc
    } else {
        puts "WARNING: No XDC file found."
    }

    puts "Setting top module to '$top'..."
    synth_design -top $top -part xc7z020clg484-1

    set_property CFGBVS VCCO [current_design]
    set_property CONFIG_VOLTAGE 3.3 [current_design]

    puts "Running optimization..."
    opt_design

    puts "Running placement..."
    place_design

    puts "Running routing..."
    route_design

    puts "Generating bitstream..."
    write_bitstream -force $top.bit

    puts "Compilation finished! Bitstream: $top.bit"
}
