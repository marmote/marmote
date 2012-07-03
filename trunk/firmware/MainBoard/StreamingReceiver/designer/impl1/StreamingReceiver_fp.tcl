new_project \
    -name {StreamingReceiver} \
    -location {D:\Work\marmote\firmware\MainBoard\StreamingReceiver\designer\impl1\StreamingReceiver_fp} \
    -mode {single}
set_device_type -type {A2F500M3G}
set_device_package -package {256 FBGA}
update_programming_file \
    -feature {prog_fpga:on} \
    -fdb_source {fdb} \
    -fdb_file {D:\Work\marmote\firmware\MainBoard\StreamingReceiver\designer\impl1\StreamingReceiver.fdb} \
    -feature {prog_from:off} \
    -feature {prog_nvm:on} \
    -efm_content {location:0;source:efc} \
    -efm_block {location:0;config_file:{D:\Work\marmote\firmware\MainBoard\StreamingReceiver\component\work\StreamingReceiver_MSS\MSS_ENVM_0\MSS_ENVM_0.efc}} \
    -pdb_file {D:\Work\marmote\firmware\MainBoard\StreamingReceiver\designer\impl1\StreamingReceiver_fp\StreamingReceiver.pdb}
set_programming_action -action {PROGRAM}
catch {run_selected_actions} return_val
save_project
close_project
if { $return_val != 0 } {
  exit 1 }
