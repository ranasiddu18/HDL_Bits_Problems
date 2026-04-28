`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2026 19:57:04
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
  input a,
    input b,
    input c,
    input d,
    output out  ); 
    assign out = ~a&~d | a&c&d | ~c&a&~b | ~a&~b&~c&d | ~a&b&c&d ;
endmodule
