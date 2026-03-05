proc run_all_test {} {

    close_sim -quiet
    close_project -quiet

    
    puts " Creating a Simulation Project"
    

    create_project -part xc7z020clg484-1 -force risc_v_sim ./sim_build 

    if {[glob -nocomplain *.v] != ""} { 
        add_files [glob *.v] 
        }

    if {[glob -nocomplain *.sv] != ""} {
        add_files [glob *.sv] 
        }

    if {[glob -nocomplain *.mem] != ""} { add_files [glob *.mem] }
    
    set_property top risc_v_tb [get_filesets sim_1]
    update_compile_order -files sim_1
    
    set test {test1 test2 test3}
    set output_dir "./sim_waveforms"

    if {![file exists $output_dir]} {
        file mkdir $output_dir
    }

foreach t $test {
        puts "Starting simulation for: $t"
        set_property generic "MEMFILE=\"$t.mem\"" [get_filesets sim_1]

        launch_simulation

        restart

        create_wave_config $t
        
        add_wave /
        add_wave -quiet /risc_v_tb/dut/instruction_F
        add_wave -quiet /risc_v_tb/dut/instruction_D
        add_wave -quiet /risc_v_tb/dut/instruction_E
        add_wave -quiet /risc_v_tb/dut/instruction_M
        add_wave -quiet /risc_v_tb/dut/instruction_W
        add_wave -quiet /risc_v_tb/dut/alu_result_E
        add_wave -quiet /risc_v_tb/dut/alu_result_M
        add_wave -quiet /risc_v_tb/dut/alu_result_W
        add_wave -quiet /risc_v_tb/dut/decode_inst/register_inst/registers
        add_wave -quiet /risc_v_tb/dut/imm_out_E
        add_wave -quiet /risc_v_tb/dut/pc_D
        add_wave -quiet /risc_v_tb/dut/pc_E
        add_wave -quiet /risc_v_tb/dut/jump_D
        add_wave -quiet /risc_v_tb/dut/jump_E

        log_wave -recursive /
        run 9000

        save_wave_config "$output_dir/$t.wcfg"

        close_sim


        set sim_run_dir "./sim_build/risc_v_sim.sim/sim_1/behav/xsim"
        set wdb_files [glob -nocomplain -directory $sim_run_dir *.wdb]

        if {[llength $wdb_files] > 0} {
            file copy -force [lindex $wdb_files 0] "$output_dir/$t.wdb"
            puts "Finished $t. Waveform and Data successfully saved."
        } else {
            puts "ERROR: Could not find .wdb file for $t"
        }
    }

    puts "All tests completed! Project files are in ./sim_build and waveforms in $output_dir"
}