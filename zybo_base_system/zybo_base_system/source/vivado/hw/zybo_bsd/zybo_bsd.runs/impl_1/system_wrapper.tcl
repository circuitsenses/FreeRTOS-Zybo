proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir G:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.cache/wt [current_project]
  set_property parent.project_dir G:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd [current_project]
  add_files -quiet G:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.runs/synth_1/system_wrapper.dcp
  read_xdc -ref system_BTNs_4Bits_0 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_BTNs_4Bits_0/system_BTNs_4Bits_0.xdc
  set_property processing_order EARLY [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_BTNs_4Bits_0/system_BTNs_4Bits_0.xdc]
  read_xdc -prop_thru_buffers -ref system_BTNs_4Bits_0 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_BTNs_4Bits_0/system_BTNs_4Bits_0_board.xdc
  set_property processing_order EARLY [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_BTNs_4Bits_0/system_BTNs_4Bits_0_board.xdc]
  read_xdc -ref system_SWs_4Bits_2 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_SWs_4Bits_2/system_SWs_4Bits_2.xdc
  set_property processing_order EARLY [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_SWs_4Bits_2/system_SWs_4Bits_2.xdc]
  read_xdc -prop_thru_buffers -ref system_SWs_4Bits_2 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_SWs_4Bits_2/system_SWs_4Bits_2_board.xdc
  set_property processing_order EARLY [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_SWs_4Bits_2/system_SWs_4Bits_2_board.xdc]
  read_xdc -ref system_axi_vdma_0_0 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_0_0/system_axi_vdma_0_0.xdc
  set_property processing_order EARLY [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_0_0/system_axi_vdma_0_0.xdc]
  read_xdc -ref system_axi_vdma_1_1 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_1_1/system_axi_vdma_1_1.xdc
  set_property processing_order EARLY [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_1_1/system_axi_vdma_1_1.xdc]
  read_xdc -ref system_processing_system7_0_0 -cells inst g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_processing_system7_0_0/system_processing_system7_0_0.xdc
  set_property processing_order EARLY [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_processing_system7_0_0/system_processing_system7_0_0.xdc]
  read_xdc G:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/constrs_1/new/base.xdc
  read_xdc -ref system_axi_vdma_0_0 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_0_0/system_axi_vdma_0_0_clocks.xdc
  set_property processing_order LATE [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_0_0/system_axi_vdma_0_0_clocks.xdc]
  read_xdc -ref system_axi_vdma_1_1 -cells U0 g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_1_1/system_axi_vdma_1_1_clocks.xdc
  set_property processing_order LATE [get_files g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.srcs/sources_1/bd/system/ip/system_axi_vdma_1_1/system_axi_vdma_1_1_clocks.xdc]
  link_design -top system_wrapper -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  catch {update_ip_catalog -quiet -current_ip_cache {g:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.cache} }
  opt_design 
  write_checkpoint -force system_wrapper_opt.dcp
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force system_wrapper_placed.dcp
  catch { report_io -file system_wrapper_io_placed.rpt }
  catch { report_clock_utilization -file system_wrapper_clock_utilization_placed.rpt }
  catch { report_utilization -file system_wrapper_utilization_placed.rpt -pb system_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file system_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force system_wrapper_routed.dcp
  catch { report_drc -file system_wrapper_drc_routed.rpt -pb system_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -file system_wrapper_timing_summary_routed.rpt -pb system_wrapper_timing_summary_routed.pb }
  catch { report_power -file system_wrapper_power_routed.rpt -pb system_wrapper_power_summary_routed.pb }
  catch { report_route_status -file system_wrapper_route_status.rpt -pb system_wrapper_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  write_bitstream -force system_wrapper.bit 
  if { [file exists G:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.runs/synth_1/system_wrapper.hwdef] } {
    catch { write_sysdef -hwdef G:/Zybo/FreeRTOS_2/zybo_base_system/zybo_base_system/source/vivado/hw/zybo_bsd/zybo_bsd.runs/synth_1/system_wrapper.hwdef -bitfile system_wrapper.bit -meminfo system_wrapper_bd.bmm -file system_wrapper.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

