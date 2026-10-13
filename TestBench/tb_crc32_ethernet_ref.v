`timescale 1ns/1ps
module tb_crc32_ethernet_ref;
  reg [31:0] crc;
  reg [7:0] data;
  wire [31:0] crc_next;
  reg [7:0] bytes [0:8];
  integer i;
  crc32_ethernet_ref dut(.crc_in(crc), .data(data), .crc_out(crc_next));
  
  initial begin
    bytes[0] = "1"; bytes[1] = "2"; bytes[2] = "3";
    bytes[3] = "4"; bytes[4] = "5"; bytes[5] = "6";
    bytes[6] = "7"; bytes[7] = "8"; bytes[8] = "9";
    crc = 32'hFFFFFFFF;
    for (i = 0; i < 9; i = i + 1) begin
      data = bytes[i];
      #1 crc = crc_next;
    end
    #1 crc = ~crc;
    if (crc !== 32'hCBF43926) begin
      $display("FAIL: CRC mismatch: %08x", crc);
      $finish;
    end
      $display("PASS: CRC-32/ISO-HDLC reference check vector");
    $finish;
    end
endmodule
