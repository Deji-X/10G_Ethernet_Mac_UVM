// Reflected Ethernet CRC-32 byte update reference.
// Polynomial reflected representation: 0xEDB88320.
// Caller initializes CRC to 0xFFFFFFFF and complements final CRC.
package crc32_ethernet_ref;
    function automatic logic [31:0] crc32_update_byte(
        input logic [31:0] crc_in,
        input logic [7:0] data
    );
        logic [31:0] c;
        integer i;
        begin
            c = crc_in ^ data;
            for (i = 0; i < 8; i = i + 1)
                c = c[0] ? ((c >> 1) ^ 32'hEDB88320) : (c >> 1);
            return c;
        end
    endfunction
endpackage
