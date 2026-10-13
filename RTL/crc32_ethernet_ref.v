// Reflected Ethernet CRC-32 byte update reference.
// Polynomial reflected representation: 0xEDB88320.
// Initialize CRC to 0xFFFFFFFF and complement the final CRC.
module crc32_ethernet_ref (
  input  wire [31:0] crc_in,
  input  wire [7:0]  data,
  output reg  [31:0] crc_out
);
  
  reg [31:0] c;
  integer i;
  always @* begin
    c = crc_in ^ {24'b0, data};
    for (i = 0; i < 8; i = i + 1)
      c = c[0] ? ((c >> 1) ^ 32'hEDB88320) : (c >> 1);
    crc_out = c;
  end
endmodule
