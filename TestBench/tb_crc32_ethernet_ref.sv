`timescale 1ns/1ps
module tb_crc32_ethernet_ref;
    import crc32_ethernet_ref::*;
    logic [31:0] crc;
    integer i;
    logic [7:0] bytes [0:8];
    initial begin
        // CRC-32/ISO-HDLC check string "123456789" => 0xCBF43926 after final XOR.
        bytes[0]="1"; bytes[1]="2"; bytes[2]="3"; bytes[3]="4"; bytes[4]="5";
        bytes[5]="6"; bytes[6]="7"; bytes[7]="8"; bytes[8]="9";
        crc=32'hFFFFFFFF;
        for(i=0;i<9;i=i+1) crc=crc32_update_byte(crc,bytes[i]);
        crc=~crc;
        if (crc !== 32'hCBF43926) $fatal(1,"CRC mismatch: %08x",crc);
        $display("PASS: CRC-32/ISO-HDLC reference check vector");
        $finish;
    end
endmodule
