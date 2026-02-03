/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_prampal_counter (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // Wire the inputs. Only enable. clock (clk) and reset (rst_n) areprovided
// Don't use system enable (ena). It only remains high when designis turned on. Create separate enable signal as done below.
wire enable = ui_in[0];
// Make the output as register
reg [3:0] counter_out;

always @ (posedge clk)
begin : counter // Block Name
// At every rising edge of clock we check if reset is active
// If active, we load the counter output with 4'b0000
if (rst_n == 1'b1) begin
counter_out <= 4'b0000;
end
// If enable is active, then we increment the counter
else if (enable == 1'b1) begin
counter_out <= counter_out + 1;
end
end

// All output pins must be assigned. If not used, assign to 0.
assign uo_out[0] = counter_out[0];
assign uo_out[1] = counter_out[1];
assign uo_out[2] = counter_out[2];
assign uo_out[3] = counter_out[3];
assign uo_out[4] = 1'b0;
assign uo_out[5] = 1'b0;
assign uo_out[6] = 1'b0;
assign uo_out[7] = 1'b0;
assign uio_out = 0;
assign uio_oe = 0;
    
  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};

endmodule
