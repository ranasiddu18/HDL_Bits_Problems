`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2026 23:05:55
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_module(
    input c,
    input d,
    output [3:0] mux_in
); 
 assign mux_in[0] = c ? 1'b1 : d;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = d ? 1'b0 : 1'b1;
    assign mux_in[3] = c ? d : 1'b0;
endmodule
