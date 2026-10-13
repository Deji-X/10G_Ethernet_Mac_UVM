// Integration note: connect this scoreboard to a monitor analysis port.
// The actual observed-frame type should include payload, FCS status, length,
// dropped/forwarded status, and relevant MAC error flags.
class mac_scoreboard extends uvm_component;
    `uvm_component_utils(mac_scoreboard)
    uvm_analysis_imp #(mac_item, mac_scoreboard) observed_export;
    int unsigned frames_checked;
    int unsigned mismatches;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        observed_export = new("observed_export", this);
    endfunction

    function void write(mac_item tr);
        // This scaffold demonstrates the analysis-imp pattern.
        // Replace with an independently computed expected-vs-observed comparison.
        frames_checked++;
        if (tr.payload.size() > 9216) begin
            mismatches++;
            `uvm_error("MAC_SB", "Observed frame exceeds configured jumbo limit")
        end
    endfunction

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("MAC_SB",
          $sformatf("frames_checked=%0d mismatches=%0d", frames_checked, mismatches),
          UVM_LOW)
        if (mismatches != 0) `uvm_error("MAC_SB", "Scoreboard found mismatches")
    endfunction
endclass
