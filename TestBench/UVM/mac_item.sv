class mac_item extends uvm_sequence_item;
    rand byte unsigned payload[];
    rand bit inject_bad_fcs;
    rand bit request_runt;
    rand bit request_oversize;
    constraint payload_size_c {
        payload.size() inside {[0:9216]};
        if (!request_runt) payload.size() inside {[46:9000]};
        if (request_runt) payload.size() inside {[0:45]};
    }
    `uvm_object_utils_begin(mac_item)
        `uvm_field_array_int(payload, UVM_ALL_ON)
        `uvm_field_int(inject_bad_fcs, UVM_ALL_ON)
        `uvm_field_int(request_runt, UVM_ALL_ON)
        `uvm_field_int(request_oversize, UVM_ALL_ON)
    `uvm_object_utils_end
    function new(string name="mac_item"); super.new(name); endfunction
endclass
