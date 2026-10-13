# 10G Ethernet MAC: Architecture and Verification Boundary

## Architecture layers
A 10G Ethernet path commonly separates:
1. Client-side packet interface (for example, AXI-Stream).
2. MAC transmit/receive logic: frame delimiters, preamble/SFD, padding, FCS, inter-frame gap, frame checking and counters.
3. Reconciliation/XGMII-style interface, commonly 64 data bits plus 8 control bits at 156.25 MHz for 10GBASE-R.
4. PCS: encoding/scrambling/block coding and lane alignment as applicable.
5. PMA/PMD and transceiver/PHY.

A MAC-only repository must state where the boundary lies. A MAC is not the same as the complete 10GBASE-R PCS/PMA or an optical/electrical PHY.

## Key transmit responsibilities
- Accept client frame bytes with unambiguous valid/ready and end-of-frame semantics.
- Emit preamble and Start Frame Delimiter.
- Transmit payload in byte order.
- Pad undersize frames to the required minimum MAC frame size where the design boundary expects MAC padding.
- Compute and append Ethernet FCS using reflected CRC-32 (polynomial 0x04C11DB7, reflected implementation constant 0xEDB88320; init/final XOR conventions must match).
- Enforce minimum inter-frame gap.
- Handle backpressure at the client boundary without corrupting a frame.
- Define behaviour for reset during a frame and malformed client transactions.

## Key receive responsibilities
- Detect frame start/end and control characters at the chosen interface.
- Strip preamble/SFD and FCS from client payload.
- Check FCS and frame length; count errors.
- Report bad frames according to a documented drop/forward policy.
- Maintain byte-lane ordering and frame boundaries.
- Define treatment of runt, oversize, malformed and errored frames.

## UVM verification model
A packet-level sequence item should include payload bytes, expected length, whether to inject a bad FCS, whether to request a runt/oversize frame, and a traffic class. The driver presents legal transactions. The monitor reconstructs observed frames. A scoreboard independently calculates expected FCS and compares payload/length/error status. Functional coverage should cross length class, payload pattern, FCS validity, backpressure pattern, reset timing, and frame spacing.

## Scope disclaimer
The RTL package in this portfolio provides a CRC reference function and UVM scaffold, not a full standards-qualified 10G MAC. A credible MAC implementation requires explicit lane-level TX/RX RTL, precise FCS byte order, IFG and padding behaviour, a complete verification environment, and validation against an independent known-good implementation or protocol compliance vectors.
